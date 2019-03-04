//
//  CommonFunction.swift
//  YPImagePicker
//
//  Created by nguyen.dong.son on 3/1/19.
//  Copyright © 2019 Yummypets. All rights reserved.
//

import Foundation

class CommonFunction {
    static let EVENT_BUTTON_CLICKS = "button_clicks"
    
    static func traceLogData(screenView: String, buttonName: String?) {
        var data = [screenView]
        if let buttonName = buttonName {
            data.append(buttonName)
            data.append(EVENT_BUTTON_CLICKS)
        }
        NotificationCenter.default
            .post(name: Notification.Name.traceLogFromYPPicker,
                  object: data)
    }
}
