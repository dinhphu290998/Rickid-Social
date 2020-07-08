//
//  LibraryTableViewCell.swift
//  Me
//
//  Created by NDPhu on 7/1/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var listUrlImages = [String]()
    var listPosts = [Post]()
    var checkSegment = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCollectionViewCell")
        collectionView.register(UINib(nibName: "NewFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "newFeedCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension LibraryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if checkSegment == 0 {
            return listUrlImages.count
        } else {
            return listPosts.count
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if checkSegment == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
            cell.libraryImageView.kf.setImage(with: URL.init(string: listUrlImages[indexPath.item]))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newFeedCollectionViewCell", for: indexPath) as! NewFeedCollectionViewCell
            cell.nameAccLabel.text(listPosts[indexPath.row].nameAccount ?? "")
            cell.contentLabel.text(listPosts[indexPath.row].content ?? "")
            cell.timeLabel.text(listPosts[indexPath.row].timeStamp?.toDay ?? "")
            if let urlStringAvatar = listPosts[indexPath.row].urlAvatar {
                cell.avatarImageView.kf.setImage(with: URL.init(string: urlStringAvatar))
                cell.avatarImageView.layer.cornerRadius = 5
            }
            if let listUrlStringContentImages = listPosts[indexPath.row].urlImages, listUrlStringContentImages.count > 0 {
                cell.imageSlideShow(listStringURL: listUrlStringContentImages)
            }
            return cell
        }
    }
    
    
}
extension LibraryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if checkSegment == 0 {
            let widthCell = ( self.collectionView.frame.width - 30 ) / 3
            return CGSize(width: widthCell, height: widthCell)
        } else {
            let widthCell = self.collectionView.frame.width - 10
            return CGSize(width: widthCell, height: screenHeight * 3 / 4)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

