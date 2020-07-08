//
//  ProfileViewController.swift
//  Me
//
//  Created by NDPhu on 6/30/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import Kingfisher
import LGButton
import FBSDKLoginKit

class ProfileViewController: UIViewController {
    
    var account: Account?
    var listURLImages = [String]()
    var listPosts = [Post]()
    let databaseRef = Database.database().reference(withPath: "posts")
    var checkSegmentCollectionView = 0
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register table cell class from nib
        let cellNib = UINib(nibName: "LibraryTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "libraryTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show()
        DataService.shared.getAccountFromFaceBook { [weak self] (account) in
            guard let weakSELF = self else {return}
            weakSELF.account = account
            weakSELF.tableView.reloadData()
        }
        DataService.shared.getAccountFromFaceBook { [weak self] (account) in
            guard let weakSELF = self else {
                SVProgressHUD.dismiss()
                return
            }
            weakSELF.account = account
            let _ = weakSELF.databaseRef.queryOrdered(byChild: "idAccount").queryEqual(toValue: "\(account.id!)").observe(.value) { [weak self] (snapshot) in
                weakSELF.listURLImages = []
                weakSELF.listPosts = []
                for childSnapshot in snapshot.children{
                    if let json = (childSnapshot as! DataSnapshot).value as? [String: Any] , let wealSELF = self {
                        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) else {return}
                        
                        do {
                            let decoder = JSONDecoder()
                            let post = try decoder.decode(Post.self, from: jsonData)
                            wealSELF.listPosts.insert(post, at: 0)
                            if let urlImages = post.urlImages {
                                for urlString in urlImages {
                                    wealSELF.listURLImages.insert(urlString, at: 0)
                                }
                            }
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
    
    @IBAction func settings(_ sender: LGButton) {
        loginManager.logOut()
        self.navigationController?.popViewController(animated: true)
    
    }
    
}

extension ProfileViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryTableViewCell", for: indexPath) as! LibraryTableViewCell
        cell.listUrlImages = self.listURLImages
        cell.listPosts = self.listPosts
        cell.checkSegment = self.checkSegmentCollectionView
        cell.collectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let aView = HeaderView()
            if let account = self.account, let picture = account.picture, account.name != nil {
                aView.nameLabel.text = account.name ?? ""
                let url = URL(string: picture.data.url)
                aView.profileImage.kf.setImage(with: url)
                aView.layer.cornerRadius = 10
            }
            view.addSubview(aView)
            return aView
        } else {
            let aView = BottomView()
            aView.delegateView = self
            view.addSubview(aView)
            return aView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return screenHeight / 4
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 0
        } else {
            return screenHeight - 100
        }
    }
}

extension ProfileViewController: BottomViewDelegate {
    func switchCollection(index: Int) {
        checkSegmentCollectionView = index
        tableView.reloadData()
    }
}
