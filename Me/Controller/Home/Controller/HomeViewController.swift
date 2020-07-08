//
//  HomeViewController.swift
//  Me
//
//  Created by NDPhu on 7/4/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import YPImagePicker
import AVFoundation
import AVKit
import Photos
import LGButton
import SVProgressHUD

class HomeViewController: UIViewController {
    
    var account: Account!
    var selectedItems = [YPMediaItem]()
    var picker = YPImagePicker()
    let databaseRef = Database.database().reference(withPath: "posts")
    var listPosts: [Post] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "NewFeedTableTableViewCell", bundle: nil), forCellReuseIdentifier: "newFeedTableTableViewCell")
        tableView.register(UINib.init(nibName: "FastNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "fastNewsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show()
        DataService.shared.getAccountFromFaceBook { [weak self] (account) in
            guard let weakSELF = self else {
                SVProgressHUD.dismiss()
                return
            }
            weakSELF.account = account
            let _ = weakSELF.databaseRef.queryOrdered(byChild: "timeStamp").observe(.value) { [weak self] (snapshot) in
                weakSELF.listPosts = []
                for childSnapshot in snapshot.children{
                    if let json = (childSnapshot as! DataSnapshot).value as? [String: Any] , let wealSELF = self {
                        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) else {return}
                        
                        do {
                            let decoder = JSONDecoder()
                            let post = try decoder.decode(Post.self, from: jsonData)
                            wealSELF.listPosts.insert(post, at: 0)
                            weakSELF.tableView.reloadData()
                            SVProgressHUD.dismiss()
                        } catch let error {
                            print(error)
                        }
                    }
                }
            }
        }
        SVProgressHUD.dismiss(withDelay: 3)
    }
    
    func showPicker() {
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photoAndVideo
        config.shouldSaveNewPicturesToAlbum = false
        config.video.compression = AVAssetExportPresetMediumQuality
        config.startOnScreen = .photo
        config.screens = [.library, .photo]
        config.video.libraryTimeLimit = 500.0
        config.showsCrop = .none
        config.wordings.libraryTitle = "Thư viện"
        config.wordings.cameraTitle = "Chụp ảnh"
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.maxCameraZoomFactor = 2.0
        config.library.maxNumberOfItems = 5
        config.gallery.hidesRemoveButton = false
        picker = YPImagePicker(configuration: config)

        picker.didFinishPicking { [unowned picker] items, cancelled in
            
            if cancelled {
                picker.dismiss(animated: true, completion: nil)
                return
            }
            _ = items.map { print("🧀 \($0)") }
                picker.dismiss(animated: true) {
                    let vc = FormViewController(nibName: "FormViewController", bundle: nil)
                    vc.items = items
                    self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func post(_ sender: LGButton) {
        showPicker()
    }
    
    @IBAction func search(_ sender: LGButton) {
        let seatchVC = SearchViewController(nibName: "SearchViewController", bundle: nil)
        self.navigationController?.pushViewController(seatchVC, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPosts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "fastNewsTableViewCell", for: indexPath) as! FastNewsTableViewCell
            DataService.shared.getAccountFromFaceBook { (account) in
                cell.account = account
            }
            cell.listPosts = self.listPosts
            cell.collectionView.reloadData()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "newFeedTableTableViewCell", for: indexPath) as! NewFeedTableTableViewCell
            cell.usernameLabel.text(listPosts[indexPath.row - 1].nameAccount ?? "")
            cell.contentTextView.text(listPosts[indexPath.row - 1].content ?? "")
            cell.timeStampLabel.text(listPosts[indexPath.row - 1].timeStamp?.toDay ?? "")
            if let urlStringAvatar = listPosts[indexPath.row - 1].urlAvatar {
                cell.avatarImageView.kf.setImage(with: URL.init(string: urlStringAvatar))
                cell.avatarImageView.layer.cornerRadius = 5
            }
            if let listUrlStringContentImages = listPosts[indexPath.row - 1].urlImages, listUrlStringContentImages.count > 0 {
                cell.imageSlideShow(listStringURL: listUrlStringContentImages)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return screenHeight / 3
        }else{
            return screenHeight * 3 / 4
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detail.post = listPosts[indexPath.row - 1]
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
