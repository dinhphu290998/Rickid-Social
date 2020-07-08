//
//  HeaderView.swift
//  Me
//
//  Created by NDPhu on 7/1/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import LGButton

class HeaderView: UIView {

    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]        
    }
    
}
