//
//  NewFeedCollectionViewCell.swift
//  Me
//
//  Created by NDPhu on 7/7/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import ImageSlideshow

class NewFeedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameAccLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func imageSlideShow(listStringURL: [String]) {
        imageSlideShow.slideshowInterval = 0
        imageSlideShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.black
        imageSlideShow.pageIndicator = pageControl
        
        imageSlideShow.activityIndicator = DefaultActivityIndicator()
        
        var localSource = [InputSource]()
        for stringURL in listStringURL {
            let imageSource = KingfisherSource.init(urlString: stringURL)
            localSource.append(imageSource!)
        }
        imageSlideShow.setImageInputs(localSource)
                
    }
}
