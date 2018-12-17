//
//  UIView+Extensions.swift
//  YPImagePicker
//
//  Created by truong.tuan.quang on 11/20/18.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: YPPickerVC.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
