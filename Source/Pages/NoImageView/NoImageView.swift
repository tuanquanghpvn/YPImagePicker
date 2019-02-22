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
    @IBOutlet weak var reloadButton: UIButton!
    
    @IBAction func reloadButtonAction(_ sender: Any) {
        reloadData?()
    }
    
    var reloadData: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.font = UIFont.notoSansCJKJP(style: .medium, size: 15)
        reloadButton.tintColor = UIColor.buttonColorGrey
        reloadButton.setTitleColor(UIColor.buttonColorGrey, for: .normal)
        reloadButton.titleLabel?.font = UIFont.notoSansCJKJP(style: .bold, size: 13)
        reloadButton.layer.borderColor = UIColor.buttonColorGrey.cgColor
        reloadButton.layer.borderWidth = 2
        reloadButton.layer.cornerRadius = reloadButton.bounds.height / 2
    }
}
