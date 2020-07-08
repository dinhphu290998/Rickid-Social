//
//  AppDelegate.swift
//  Me
//
//  Created by NDPhu on 6/28/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//
    
import UIKit
import FBSDKCoreKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        storage = Storage.storage(url:"gs://my-custom-bucket")
        
        return true
    }

    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()
    }
}


 
    
