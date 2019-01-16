//
//  YPStickerVC+.swift
//  YPImagePicker
//
//  Created by nguyen.dong.son on 1/15/19.
//  Copyright © 2019 Yummypets. All rights reserved.
//

import Foundation
import UIKit

protocol YPStickersVCDelegate {
    func didSelectView(view: UIView)
    func didSelectImage(imageView: UIImageView)
    func deleteImageInView(imageView: UIImageView)
}

extension YPStickersVC: YPStickersVCDelegate {
    
    func didSelectView(view: UIView) {
        view.center = imageContainSticker.center
        self.imageContainSticker.addSubview(view)
        addGestures(view: view)
    }
    
    func didSelectImage(imageView: UIImageView) {
        let xoffset = CGFloat(arc4random_uniform(UInt32(imageContainSticker.bounds.width / 4)) + 100)
        let yoffset = CGFloat(arc4random_uniform(UInt32(imageContainSticker.bounds.height / 4)) + 100)
        
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: xoffset, y: yoffset, width: 500, height: 500)
        addGestures(view: imageView)
        self.imageContainSticker.addSubview(imageView)
        UIView.animate(withDuration: 0.25) { () -> Void in
            imageView.frame.size = CGSize(width: 150, height: 150)
        }
    }
    
    func deleteImageInView(imageView: UIImageView) {
        if let viewWithTag = self.imageContainSticker.viewWithTag(imageView.tag) {
            UIView.animate(withDuration: 0.2, animations: {
                viewWithTag.frame.size = CGSize(width: 0, height: 0)
            },
            completion: { _ in UIView.animate(withDuration: 0.1) {
                    viewWithTag.removeFromSuperview()
                }
            })
        }
    }
    
    func addGestures(view: UIView) {
        view.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(YPStickersVC.panGesture))
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)

        let pinchGesture = UIPinchGestureRecognizer(target: self,
                                                    action: #selector(YPStickersVC.pinchGesture))
        pinchGesture.delegate = self
        view.addGestureRecognizer(pinchGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(YPStickersVC.longPressGesture))
        longPressGesture.minimumPressDuration = 0.05
        longPressGesture.delegate = self
//        view.addGestureRecognizer(longPressGesture)
    }
}
