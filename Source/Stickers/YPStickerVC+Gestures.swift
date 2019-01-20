//
//  YPStickerVC+Gestures.swift
//  YPImagePicker
//
//  Created by nguyen.dong.son on 1/15/19.
//  Copyright © 2019 Yummypets. All rights reserved.
//

import Foundation
import UIKit

extension YPStickersVC: UIGestureRecognizerDelegate {
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        if let view = recognizer.view {
            moveView(view: view, recognizer: recognizer)
        }
    }
    
    @objc func pinchGesture(_ recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    @objc func rotationGesture(_ recognizer: UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    @objc func tapGesture(_ recognizer: UITapGestureRecognizer) {
        if let view = recognizer.view {
            if view is UIImageView {
                for imageView in subImageViews(view: imageContainSticker) {
                    let location = recognizer.location(in: imageView)
                    let alpha = imageView.alphaAtPoint(location)
                    if alpha > 0 {
                        scaleEffect(view: imageView)
                        break
                    }
                }
            } else {
                scaleEffect(view: view)
            }
        }
    }
    
    @objc func longPressGesture(_ recognizer: UIPanGestureRecognizer) {
        if let view = recognizer.view {
            if view is UIImageView {
                view.superview?.bringSubviewToFront(view)
                if recognizer.state == .began {
                    UIView.animate(withDuration: 0.1, animations: {
                        view.transform = view.transform.scaledBy(x: 1.5, y: 1.5)
                    })
                }
                if recognizer.state == .ended || recognizer.state == .failed {
                    UIView.animate(withDuration: 0.1, animations: {
                        view.transform = view.transform.scaledBy(x: 2 / 3, y: 2 / 3)
                    })
                }
            }
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    func scaleEffect(view: UIView) {
        view.superview?.bringSubviewToFront(view)
        let previouTransform =  view.transform
        UIView.animate(withDuration: 0.05, animations: {
            view.transform = view.transform.scaledBy(x: 1.2, y: 1.2)
        },
        completion: { _ in UIView.animate(withDuration: 0.05) {
                view.transform  = previouTransform
           }
        })
    }
    
    func moveView(view: UIView, recognizer: UIPanGestureRecognizer)  {
        view.superview?.bringSubviewToFront(view)
        view.center = CGPoint(x: view.center.x + recognizer.translation(in: imageContainSticker).x,
                              y: view.center.y + recognizer.translation(in: imageContainSticker).y)
        
        recognizer.setTranslation(CGPoint.zero, in: imageContainSticker)
    }
    
    func subImageViews(view: UIView) -> [UIImageView] {
        var imageviews: [UIImageView] = []
        for imageView in view.subviews {
            if imageView is UIImageView {
                imageviews.append(imageView as! UIImageView)
            }
        }
        return imageviews
    }
}
