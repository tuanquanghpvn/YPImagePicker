//
//  YPStickerCollectionViewCell.swift
//  YPImagePicker
//
//  Created by Quang on 12/17/18.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import UIKit

class YPStickerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stickerImageView: UIImageView!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var choiceImageView: UIImageView!
    @IBOutlet weak var containView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    fileprivate func configView() {
        containView.layer.cornerRadius = 5
    }
    
    func configData(ypSticker: YPSticker, isAlreadyChoice: Bool) {
        newImageView?.isHidden = !ypSticker.isNew
        choiceImageView?.isHidden = !isAlreadyChoice
        guard let stickerImage = ypSticker.image else { return }
        stickerImageView?.image = stickerImage
    }
}
