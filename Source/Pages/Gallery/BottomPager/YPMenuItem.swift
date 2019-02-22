//
//  YPMenuItem.swift
//  YPImagePicker
//
//  Created by Sacha DSO on 24/01/2018.
//  Copyright © 2016 Yummypets. All rights reserved.
//

import UIKit
import Stevia

final class YPMenuItem: UIView {
    
    var textLabel = PaddingLabel()
    var button = UIButton()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    func setup() {
        backgroundColor = .clear
        
        sv(
            textLabel,
            button
        )
        
        textLabel.centerInContainer()
        // TODO: QuangTT Custom
//        |-(10)-textLabel-(10)-|
        |-(5)-textLabel-(5)-|
        button.fillContainer()
        
        textLabel.style { l in
            // TODO: QuangTT Custom
//            l.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
            l.font = UIFont.notoSansCJKJP(style: .bold, size: 15)
            l.textColor = self.unselectedColor()
            l.adjustsFontSizeToFitWidth = true
            l.numberOfLines = 2
        }
    }
    
    func setTextAlignment(centerAlignment: Bool, leftAlignment: Bool, rightAlignment: Bool) {
        textLabel.style { l in
            if centerAlignment {
                l.textAlignment = .center
            }
            
            if leftAlignment {
                l.textAlignment = .left
            }
            
            if rightAlignment {
                l.textAlignment = .right
            }
        }
    }
    
    func setPadding(padding: UIEdgeInsets) {
        textLabel.style { l in
            l.topInset = padding.top
            l.leftInset = padding.left
            l.rightInset = padding.right
            l.bottomInset = padding.bottom
        }
    }
    
    func selectedColor() -> UIColor {
        return YPImagePickerConfiguration.shared.bottomMenuItemSelectedColour
    }
    
    func unselectedColor() -> UIColor {
        return YPImagePickerConfiguration.shared.bottomMenuItemUnSelectedColour
    }
    
    func select() {
        textLabel.textColor = selectedColor()
    }
    
    func deselect() {
        textLabel.textColor = unselectedColor()
    }
}
