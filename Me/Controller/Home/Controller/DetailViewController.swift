//
//  DetailViewController.swift
//  Me
//
//  Created by NDPhu on 7/7/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import ImageSlideshow
import LGButton

class DetailViewController: UIViewController {

    @IBOutlet weak var slideImage: ImageSlideshow!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    var post: Post?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let post = self.post {
            username.text(post.nameAccount ?? "")
            content.text(post.content ?? "")
            timeStamp.text(post.timeStamp?.toDay ?? "")
            if let urlStringAvatar = post.urlAvatar {
                avatarImageView.kf.setImage(with: URL.init(string: urlStringAvatar))
                avatarImageView.layer.cornerRadius = 5
            }
            if let listUrlStringContentImages = post.urlImages, listUrlStringContentImages.count > 0 {
                self.imageSlideShow(listStringURL: listUrlStringContentImages)
            }
        }
    }
    
    @IBAction func back(_ sender: LGButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func imageSlideShow(listStringURL: [String]) {
        slideImage.slideshowInterval = 0
        slideImage.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        slideImage.contentScaleMode = UIViewContentMode.scaleAspectFill
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.black
        slideImage.pageIndicator = pageControl
        
        slideImage.activityIndicator = DefaultActivityIndicator()
        
        var localSource = [InputSource]()
        for stringURL in listStringURL {
            let imageSource = KingfisherSource.init(urlString: stringURL)
            localSource.append(imageSource!)
        }
        slideImage.setImageInputs(localSource)
    }

}
