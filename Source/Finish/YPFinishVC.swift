//
//  YPFinishVC.swift
//  YPImagePicker
//
//  Created by truong.tuan.quang on 11/20/18.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import UIKit
import Photos

class YPFinishVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var containView: UIView!
    
    // MARK: - Properties

    public var inputPhoto: YPMediaPhoto!
    public var didSave: ((YPMediaItem) -> Void)?
    public var didCancel: (() -> Void)?
    public var selectedFilter: YPFilter?
    public var currentlySelectedImageThumbnail: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: YPConfig.icons.closeIcon,
                                                            style: UIBarButtonItem.Style.plain,
                                                            target: self, action: #selector(close))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            CommonFunction.traceLogData(screenView: YPWordings().pH06, buttonName: YPWordings().backButton)
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CommonFunction.traceLogData(screenView: YPWordings().pH06, buttonName: nil)
    }
    
    deinit {
        print("Picker YP Deinit")
    }
    
    // MARK: - Methods
    
    @objc func backAction() {
        CommonFunction.traceLogData(screenView: YPWordings().pH06, buttonName: YPWordings().backButton)
        navigationController?.popViewController(animated: true)
    }
    
    private func configView() {
        title = "確認・完了"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.notoSansCJKJP(style: .bold, size: 15),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        removeBackButtonTitle()
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2
        saveButton.titleLabel?.font = UIFont.notoSansCJKJP(style: .bold, size: 15)
        imageView?.contentMode = .scaleAspectFit
        imageView?.layer.cornerRadius = 10
        imageView?.clipsToBounds = true
        imageView?.image = currentlySelectedImageThumbnail ?? inputPhoto.originalImage
    }
    
    func removeBackButtonTitle() {
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc
    func close() {
        self.didCancel?()
        CommonFunction.traceLogData(screenView: YPWordings().pH06, buttonName: YPWordings().pH01Close)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonClicked(_ sender: AnyObject) {
        CommonFunction.traceLogData(screenView: YPWordings().pH06, buttonName: YPWordings().pH06Save)
        self.inputPhoto.modifiedImage = UIImage.imageWithView(self.containView)
        checkPermission()
    }
    
    func checkPermission() {
        checkPermissionToAccessPhotoLibrary { [weak self] hasPermission in
            guard let strongSelf = self else {
                return
            }
            if hasPermission {
               strongSelf.didSave?(YPMediaItem.photo(p: strongSelf.inputPhoto))
            } else {
               strongSelf.showAlert()
            }
        }
    }
    
    // Async beacause will prompt permission if .notDetermined
    // and ask custom popup if denied.
    func checkPermissionToAccessPhotoLibrary(block: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            block(true)
        case .restricted, .denied:
            block(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { s in
                DispatchQueue.main.async {
                    block(s == .authorized)
                }
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "ライブラリの利用を許可してください。",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
