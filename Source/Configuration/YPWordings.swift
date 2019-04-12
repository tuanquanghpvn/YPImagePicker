//
//  YPWordings.swift
//  YPImagePicker
//
//  Created by Sacha DSO on 12/03/2018.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import Foundation

public struct YPWordings {
    
    public var permissionPopup = PermissionPopup()
    public var videoDurationPopup = VideoDurationPopup()

    public struct PermissionPopup {
        public var title = ypLocalized("YPImagePickerPermissionDeniedPopupTitle")
        public var message = ypLocalized("YPImagePickerPermissionDeniedPopupMessage")
        public var cancel = ypLocalized("YPImagePickerPermissionDeniedPopupCancel")
        public var grantPermission = ypLocalized("YPImagePickerPermissionDeniedPopupGrantPermission")
    }
    
    public struct VideoDurationPopup {
        public var title = ypLocalized("YPImagePickerVideoDurationTitle")
        public var tooShortMessage = ypLocalized("YPImagePickerVideoTooShort")
        public var tooLongMessage = ypLocalized("YPImagePickerVideoTooLong")
    }
    
    public var ok = ypLocalized("YPImagePickerOk")
    public var done = ypLocalized("YPImagePickerDone")
    public var cancel = ypLocalized("YPImagePickerCancel")
    public var save = ypLocalized("YPImagePickerSave")
    public var processing = ypLocalized("YPImagePickerProcessing")
    public var trim = ypLocalized("YPImagePickerTrim")
    public var cover = ypLocalized("YPImagePickerCover")
    public var albumsTitle = ypLocalized("YPImagePickerAlbums")
    public var libraryTitle = ypLocalized("YPImagePickerLibrary")
    public var cameraTitle = ypLocalized("YPImagePickerPhoto")
    public var videoTitle = ypLocalized("YPImagePickerVideo")
    public var next = ypLocalized("YPImagePickerNext")
    public var filter = ypLocalized("YPImagePickerFilter")
    public var crop = ypLocalized("YPImagePickerCrop")
    public var warningMaxItemsLimit = ypLocalized("YPImagePickerWarningItemsLimit")
    
    // MARK: - screen
    public var pH01 = "アースフォト-library（タブ）"
    public var pH02 = "アースフォト-photo（タブ）"
    public var pH03 = "アースフォト-切り抜き場所選択"
    public var pH04 = "アースフォト - フィルター選択"
    public var pH05 = "アースフォト - スタンプ選択"
    public var pH06 = "アースフォト - 確認/保存"
    
    // MARK: - button event
    public var backButton = "ボタン(戻る)"
    public var pH01Close = "ボタン(閉じる)"
    public var pH01Image = "写真"
    public var pH01Library = "library"
    public var pH01Photo = "photo"
    public var pH02ChangeCamera = "カメラ切り替え"
    public var pH02Flash = "フラッシュ"
    public var pH02TakepHoto = "シャッター"
    public var pH03ChooseImage = "写真"
    public var pH03Next = "決定"
    public var pH04FilterName = "フィルター"
    public var pH05StampName = "スタンプ"
    public var pH06Save = "ライブラリに保存"
}
