//
//  YPStickerCollectionViewCell.swift
//  YPImagePicker
//
//  Created by Quang on 12/17/18.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import UIKit

class YPStickerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var stickerImageView: UIImageView!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var choiceImageView: UIImageView!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadingIndicator?.isHidden = true
        stickerImageView.image = nil
    }
    
    // MARK: - Methods

    fileprivate func configView() {
        containView.layer.cornerRadius = 5
    }
    
    func configData(ypSticker: YPSticker, isAlreadyChoice: Bool) {
        newImageView?.isHidden = !ypSticker.isNew
        choiceImageView?.isHidden = !isAlreadyChoice
        guard let stickerUrl = ypSticker.imageUrl else { return }
        loadingIndicator?.startAnimating()
        DownloadHelpers.downloadImage(url: stickerUrl) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.loadingIndicator?.isHidden = true
                self?.stickerImageView?.image = image
            }
        }
    }
}
