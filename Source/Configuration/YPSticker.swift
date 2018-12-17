//
//  YPSticker.swift
//  YPImagePicker
//
//  Created by Quang on 12/17/18.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import Foundation
import UIKit

public struct YPSticker {
    public var id: Int
    public var isNew: Bool
    public var image: UIImage?
    
    public init(id: Int, isNew: Bool, image: UIImage?) {
        self.id = id
        self.isNew = isNew
        self.image = image
    }
}
