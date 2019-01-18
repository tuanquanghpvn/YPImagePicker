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
    func deleteImageInView(id: Int)
}

extension YPStickersVC: YPStickersVCDelegate {
    
    func didSelectView(view: UIView) {
        view.center = imageContainSticker.center
        self.imageContainSticker.addSubview(view)
        addGestures(view: view)
    }
    
    func didSelectImage(imageView: UIImageView) {
        // Height And With Of Image
        let widthInPoints = imageView.image?.size.width ?? 160.0
        let heightInPoints = imageView.image?.size.height ?? 120.0
        
        // Set Position
        var xoffset = CGFloat(arc4random_uniform(UInt32(imageContainSticker.bounds.width)))
        var yoffset = CGFloat(arc4random_uniform(UInt32(imageContainSticker.bounds.height)))
        if xoffset + widthInPoints >= imageContainSticker.frame.maxX {
            xoffset = xoffset - widthInPoints
        }
        if yoffset + heightInPoints >= imageContainSticker.frame.maxY {
            yoffset = yoffset - heightInPoints
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: xoffset, y: yoffset, width: widthInPoints, height: heightInPoints)
        imageView.transform = CGAffineTransform(scaleX: 2.2, y: 2.2)
        imageView.alpha = 0
        addGestures(view: imageView)
        self.imageContainSticker.addSubview(imageView)
        UIView.animate(withDuration: 0.3, animations: {
            imageView.alpha = 1
            imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (_) in
            imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func deleteImageInView(id: Int) {
        if let viewWithTag = self.imageContainSticker.viewWithTag(id) {
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
