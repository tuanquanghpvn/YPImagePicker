//
//  YPFinishVC.swift
//  YPImagePicker
//
//  Created by truong.tuan.quang on 11/20/18.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import UIKit

class YPFinishVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
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
    
    deinit {
        print("Picker YP Deinit")
    }
    
    private func configView() {
        navigationItem.title = "確認・完了"
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2
        imageView?.contentMode = .scaleAspectFit
        imageView?.layer.cornerRadius = 10
        imageView?.clipsToBounds = true
        imageView?.image = currentlySelectedImageThumbnail ?? inputPhoto.originalImage
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: YPConfig.icons.closeIcon,
                                                           style: UIBarButtonItem.Style.plain,
                                                           target: self, action: #selector(close))
    }
    
    @objc
    func close() {
        self.didCancel?()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonClicked(_ sender: AnyObject) {
        navigationItem.rightBarButtonItem = YPLoaders.defaultLoader
        saveButton?.isEnabled = false
        DispatchQueue.global().async {
            if let f = self.selectedFilter,
                let applier = f.applier,
                let ciImage = self.inputPhoto.originalImage.toCIImage(),
                let modifiedFullSizeImage = applier(ciImage) {
                self.inputPhoto.modifiedImage = modifiedFullSizeImage.toUIImage()
            } else {
                self.inputPhoto.modifiedImage = nil
            }
            DispatchQueue.main.async {
                self.didSave?(YPMediaItem.photo(p: self.inputPhoto))
            }
        }
    }
}
