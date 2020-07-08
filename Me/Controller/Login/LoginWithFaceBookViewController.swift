//
//  LoginWithFaceBookViewController.swift
//  Me
//
//  Created by NDPhu on 6/28/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import LGButton
import SVProgressHUD
import Firebase
import FBSDKLoginKit

class LoginWithFaceBookViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginWithFB(_ sender: LGButton) {
        SVProgressHUD.show()
        self.loginWithFacebook { [weak self] (success,new) in
            if success {
                print("Đăng nhập thành công")
                self?.performSegue(withIdentifier: "pushToHome", sender: nil)
                DataService.shared.getAccountFromFaceBook { [weak self] (account) in
                    guard let weakSELF = self else {return}
                    if let name = account.name , let id = account.id , let picture = account.picture, new == true  {
                        weakSELF.uploadAccout(id: id, name: name, timeStamp: Date().convertDateToTimeInterval(), location: "", lat: 0, lon: 0, urlImage: picture.data.url) {
                        }
                        SVProgressHUD.dismiss()
                    }
                }
            } else {
                SVProgressHUD.dismiss()
                print("Không đăng nhập được")
            }
        }
        SVProgressHUD.dismiss(withDelay: 3)
    }
    
    func uploadAccout(id: String,name: String,timeStamp: TimeInterval,location:String,lat:Double,lon:Double,urlImage:String, completion: @escaping () -> Void ) {
        let parameter = ["idAccount":id,"timeStamp":timeStamp, "nameAccount":name,"location":location,"urlImage":urlImage,"lat":lat,"lon":lon] as [String : Any]
        let database = Database.database().reference().child("accounts").childByAutoId()
        database.setValue(parameter) { (err, databaseRef) in
            if err != nil {
                print(err!)
            } else {
                completion()
            }
        }
    }
}
