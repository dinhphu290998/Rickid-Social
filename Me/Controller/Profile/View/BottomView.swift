//
//  BottomView.swift
//  Me
//
//  Created by NDPhu on 7/1/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import LGButton

protocol BottomViewDelegate: class {
    func switchCollection(index: Int)
}
class BottomView: UIView {

    @IBOutlet var contentView: UIView!
    var delegateView: BottomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("BottomView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    @IBAction func libraryButton(_ sender: LGButton) {
        delegateView?.switchCollection(index: 0)
    }
    
    @IBAction func showPost(_ sender: LGButton) {
        delegateView?.switchCollection(index: 1)
    }
    
}
