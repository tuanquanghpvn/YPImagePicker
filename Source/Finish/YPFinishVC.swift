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
        navigationItem.rightBarButtonItem = YPLoaders.defaultLoader
        saveButton?.isEnabled = false
        self.inputPhoto.modifiedImage = UIImage.imageWithView(self.containView)
        self.didSave?(YPMediaItem.photo(p: self.inputPhoto))
    }
}
