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
    /**
     - Parameter view: selected view from YPStickersVC
     */
    func didSelectView(view: UIView)
    /**
     - Parameter image: selected Image from YPStickersVC
     */
    func didSelectImage(image: UIImage)
    /**
     StickersViewController did Disappear
     */
    func stickersViewDidDisappear()
}


extension YPStickersVC {
    
    func addStickersViewController() {
        
    }
    
    func removeStickersView() {
       
    }
}

extension YPStickersVC: YPStickersVCDelegate {
    
    func didSelectView(view: UIView) {
        
    }
    
    func didSelectImage(image: UIImage) {
        
    }
    
    func stickersViewDidDisappear() {
        
    }
    
    func addGestures(view: UIView) {
        //Gestures
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(YPStickersVC.tapGesture))
        view.addGestureRecognizer(tapGesture)
        
    }
}
