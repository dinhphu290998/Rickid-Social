//
//  Comment.swift
//  Me
//
//  Created by NDPhu on 6/29/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import Foundation

struct Comment: Codable {
    var id: Int?
    var postId: Int?
    var userId: Int?
    var content: String?
    var timeStamp: String?
}
