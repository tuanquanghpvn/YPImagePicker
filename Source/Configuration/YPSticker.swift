//
//  YPSticker.swift
//  YPImagePicker
//
//  Created by Quang on 12/17/18.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import Foundation
import UIKit

public enum PhotoStampType: String {
    case text = "TEXT"
    case image = "IMAGE"
}

public struct YPSticker {
    public var id: Int
    public var isNew: Bool
    public var imageUrl: URL?
    public var photoStampType: PhotoStampType
    
    public init(id: Int, isNew: Bool, photoStampType: PhotoStampType, imageUrl: URL?) {
        self.id = id
        self.isNew = isNew
        self.imageUrl = imageUrl
        self.photoStampType = photoStampType
    }
}
