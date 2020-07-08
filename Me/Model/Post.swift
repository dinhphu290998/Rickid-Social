//
//  Post.swift
//  Me
//
//  Created by NDPhu on 7/5/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import Foundation
import UIKit

struct Post: Codable {
    var idPost: String?
    var idAccount: String?
    var nameAccount: String?
    var urlImages: [String]?
    var urlAvatar: String?
    var timeStamp: TimeInterval?
    var content: String?
    var location: String?
    var likes: [Like]?
    var comments: [Comment]?
}
