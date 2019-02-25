//
//  YPPagerMenu.swift
//  YPImagePicker
//
//  Created by Sacha DSO on 24/01/2018.
//  Copyright © 2016 Yummypets. All rights reserved.
//

import UIKit
import Stevia

final class YPPagerMenu: UIView {
    
    var didSetConstraints = false
    var menuItems = [YPMenuItem]()
    
    convenience init() {
        self.init(frame: .zero)
        // TODO: QuangTT Custom
//        backgroundColor = UIColor(r: 247, g: 247, b: 247)
        backgroundColor = UIColor.white
        clipsToBounds = true
    }
    
    var separators = [UIView]()
    
    func setUpMenuItemsConstraints() {
        let menuItemWidth: CGFloat = UIScreen.main.bounds.width / CGFloat(menuItems.count)
        var previousMenuItem: YPMenuItem?
        for m in menuItems {
            
            sv(
                m
            )
            m.fillVertically().width(menuItemWidth)
            if let pm = previousMenuItem {
                pm-0-m
            } else {
                |m
            }
            
            previousMenuItem = m
        }
        
        if menuItems.count == 2 {
            menuItems[0].setTextAlignment(centerAlignment: false, leftAlignment: false, rightAlignment: true)
            menuItems[0].setPadding(padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20))
            menuItems[1].setTextAlignment(centerAlignment: false, leftAlignment: true, rightAlignment: false)
            menuItems[1].setPadding(padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !didSetConstraints {
            setUpMenuItemsConstraints()
        }
        didSetConstraints = true
    }
    
    func refreshMenuItems() {
        didSetConstraints = false
        updateConstraints()
    }
}
