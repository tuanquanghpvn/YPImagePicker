//
//  NoImageView.swift
//  YPImagePicker
//
//  Created by nguyen.dong.son on 2/20/19.
//  Copyright © 2019 Yummypets. All rights reserved.
//

import UIKit

class NoImageView: UIView {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var reloadData: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.font = UIFont.notoSansCJKJP(style: .medium, size: 15)
        addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                    action: #selector(NoImageView.tapHeader(_:))))
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        reloadData?()
    }
}
