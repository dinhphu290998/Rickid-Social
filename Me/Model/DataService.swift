//
//  DataService.swift
//  Me
//
//  Created by NDPhu on 6/29/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//
import UIKit
import Foundation

import Firebase
import FirebaseDatabase

import FBSDKLoginKit

let loginManager = LoginManager()
var storage = Storage.storage()
let storageRef = storage.reference()

extension UIViewController {
    func loginWithFacebook(complete: @escaping (Bool,Bool) -> Void) {
        if let token = AccessToken.current, !token.isExpired {
            complete(true,false)
        } else {
            loginManager.logIn(permissions: [], from: self) { (result, error) in
                guard error == nil else {
                    complete(false,true)
                    return
                }
                guard let result = result, !result.isCancelled else {
                    complete(false,true)
                    return
                }
                complete(true,true)
            }
        }
    }
}

class DataService {
    
    static let shared = DataService()
    
    func getAccountFromFaceBook(complete: @escaping (Account) -> Void) {
        if let accessToken = AccessToken.current?.tokenString {
            let request = GraphRequest(graphPath: "me", parameters: ["fields":"id,email,name,picture.type(large)"], tokenString: accessToken, version: nil, httpMethod: .get)
            request.start { (response, result , error) in
                guard let json = result as? [String: Any] else {return}
                guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) else {return}
                do {
                    let decoder = JSONDecoder()
                    let account = try decoder.decode(Account.self, from: jsonData)
                    complete(account)
                } catch let error {
                    print(error)
                }
            }
        }
    }
}


