//
//  Account.swift
//  Me
//
//  Created by NDPhu on 6/29/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

@objcMembers class Account: Object, Codable {
    dynamic var id: String?
    dynamic var name: String?
    dynamic var picture: Picture?
    dynamic var gmail: String?
    dynamic var location: String?
    dynamic var lat: Double?
    dynamic var lon: Double?
    dynamic var timeStamp: TimeInterval?
}

struct Picture: Codable {
    var data: DataPicture
}

struct DataPicture: Codable {
    var url: String
}
