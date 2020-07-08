//
//  NewFeedTableTableViewCell.swift
//  Me
//
//  Created by NDPhu on 7/6/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import LGButton
import ImageSlideshow
import Kingfisher
class NewFeedTableTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfLikeLabel: UIButton!
    @IBOutlet weak var numberOfCommentLabel: UILabel!
    @IBOutlet weak var sharedButton: LGButton!
    @IBOutlet weak var commentButton: LGButton!
    @IBOutlet weak var likeButton: LGButton!
    @IBOutlet weak var viewContentImage: ImageSlideshow!
    @IBOutlet weak var contentTextView: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func imageSlideShow(listStringURL: [String]) {
        viewContentImage.slideshowInterval = 0
        viewContentImage.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        viewContentImage.contentScaleMode = UIViewContentMode.scaleAspectFill
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.black
        viewContentImage.pageIndicator = pageControl
        
        viewContentImage.activityIndicator = DefaultActivityIndicator()
        
        var localSource = [InputSource]()
        for stringURL in listStringURL {
            let imageSource = KingfisherSource.init(urlString: stringURL)
            localSource.append(imageSource!)
        }
        viewContentImage.setImageInputs(localSource)
                
    }
    
    @IBAction func like(_ sender: LGButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            sender.leftImageSrc = UIImage.init(named: "heart_select_ic")
        } else {
            sender.leftImageSrc = UIImage.init(named: "heart_ic")
        }
    }
    
}
