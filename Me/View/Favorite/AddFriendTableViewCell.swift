//
//  AddFriendTableViewCell.swift
//  Me
//
//  Created by NDPhu on 7/8/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit

class AddFriendTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        photo.layer.cornerRadius = photo.frame.width/2
        photo.layer.masksToBounds = true
        deleteButton.layer.cornerRadius = 10
        confirmButton.layer.cornerRadius = 10
        acceptButton.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func confirm(_ sender: UIButton) {
        confirmButton.isHidden = true
        acceptButton.isHidden = false
    }
    
}
