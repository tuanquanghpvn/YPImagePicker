//
//  UIFont+Additions.swift
//  Stripe
//
//  Created by truong.tuan.quang on 11/6/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    // MARK: - NotoSans
    
    enum NotoSansCJKJPStyle {
        case regular
        case bold
        case light
        case medium
        
        var name: String {
            switch self {
            case .regular:
                return "NotoSansCJKjp-Regular"
            case .bold:
                return "NotoSansCJKjp-Bold"
            case .light:
                return "NotoSansCJKjp-Light"
            case .medium:
                return "NotoSansCJKjp-Medium"
            }
        }
    }
    
    static func notoSansCJKJP(style: NotoSansCJKJPStyle = .regular, size: CGFloat) -> UIFont {
        guard
            let font = UIFont(name: style.name, size: size) else {
                return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}

