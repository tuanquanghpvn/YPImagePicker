//
//  LibraryPermissionView.swift
//  YPImagePicker
//
//  Created by truong.tuan.quang on 11/20/18.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import UIKit

class LibraryPermissionView: UIView {
    
    var toSetting: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Actions
    
    @IBAction func requestPermissionClicked(_ sender: AnyObject) {
        toSetting?()
    }
}
