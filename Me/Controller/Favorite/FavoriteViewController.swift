//
//  FavoriteViewController.swift
//  Me
//
//  Created by NDPhu on 7/8/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import Kingfisher

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var listAccounts = [Friend]()
    let databaseRef = Database.database().reference(withPath: "accounts")
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "AddFriendTableViewCell", bundle: nil), forCellReuseIdentifier: "AddFriendTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchListAcc()
    }
    
    func fetchListAcc() {
        SVProgressHUD.show()
        let _ = self.databaseRef.queryOrdered(byChild: "location").observe(.value) { [weak self] (snapshot) in
            guard let weakSELF = self else {return}
            weakSELF.listAccounts = []
            for childSnapshot in snapshot.children{
                if let json = (childSnapshot as! DataSnapshot).value as? [String: Any] , let wealSELF = self {
                    print(json)
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) else {return}
                    
                    do {
                        let decoder = JSONDecoder()
                        let friend = try decoder.decode(Friend.self, from: jsonData)
                        wealSELF.listAccounts.insert(friend, at: 0)
                        weakSELF.tableView.reloadData()
                        SVProgressHUD.dismiss()
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
    }
}

extension FavoriteViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddFriendTableViewCell", for: indexPath) as! AddFriendTableViewCell
        cell.username.text = listAccounts[indexPath.row].nameAccount
        if let urlStringAvatar = listAccounts[indexPath.row].urlImage {
            cell.photo.kf.setImage(with: URL.init(string: urlStringAvatar))
            cell.photo.layer.cornerRadius = 5
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
