//
//  FastNewsTableViewCell.swift
//  Me
//
//  Created by NDPhu on 7/6/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit

class FastNewsTableViewCell: UITableViewCell {
    var account: Account?
    var listPosts: [Post] = []
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FastNewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "fastNewsCollectionViewCell")
        collectionView.register(UINib(nibName: "DefautFastNewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "defautFastNewsCollectionViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension FastNewsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPosts.count + 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defautFastNewsCollectionViewCell", for: indexPath) as! DefautFastNewsCollectionViewCell
                if account != nil, let picture = account!.picture {
                    let url = URL(string: picture.data.url)
                    cell.userImageView.kf.setImage(with: url)
                }
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fastNewsCollectionViewCell", for: indexPath) as! FastNewsCollectionViewCell
                if let urlStringAVT = listPosts[indexPath.item - 1].urlAvatar {
                    cell.avatar.kf.setImage(with: URL.init(string: urlStringAVT))
                }
                cell.username.text = listPosts[indexPath.item - 1].nameAccount
                if let listURLStringIMG = listPosts[indexPath.item - 1].urlImages, listURLStringIMG.count != 0 {
                    cell.contentImage.kf.setImage(with: URL.init(string: listURLStringIMG.first!))
                    cell.contentImage.contentMode = .scaleAspectFill
                }
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
                return cell
            }
        }
        
        
    }
extension FastNewsTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightCell = self.collectionView.frame.height - 20
        return CGSize(width: heightCell*2/3, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
