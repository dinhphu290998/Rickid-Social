//
//  VideoTableViewCell.swift
//  Mai Duyên
//
//  Created by vMio on 6/13/19.
//  Copyright © 2019 VMio. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var aView: UIView!
    @IBOutlet weak var photo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        photo.layer.cornerRadius = photo.frame.width/2
        photo.layer.masksToBounds = true
    }

    func playVideoWithURL(string: String) {
        if let url = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4") {
            //2. Create AVPlayer object
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            let player = AVPlayer(playerItem: playerItem)
            
            //3. Create AVPlayerLayer object
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.aView.bounds //bounds of the view in which AVPlayer should be displayed
            playerLayer.videoGravity = .resizeAspect
            
            //4. Add playerLayer to view's layer
            self.aView.layer.addSublayer(playerLayer)
            
            //5. Play Video
            player.play()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func statusBt(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func playVideo(_ sender: UIButton) {

    }
}
