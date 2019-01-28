//
//  YPStickersVC.swift
//  YPImagePicker
//
//  Created by Quang on 12/17/18.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import UIKit

class YPStickersVC: UIViewController {
    
    struct CustomCell {
        var isSeperator: Bool
        var infoImage: YPSticker?
    }
    
    var dataSource: [CustomCell] = []
    var countImageSticker = 0
    var countTextSticker = 0
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageContainSticker: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    
    public var inputPhoto: YPMediaPhoto!
    public var didSave: ((YPMediaItem) -> Void)?
    public var didCancel: (() -> Void)?
    public var selectedFilter: YPFilter?
    public var currentlySelectedImageThumbnail: UIImage?
    
    // MARK: - Private Properties
    
    fileprivate var choiceStickers: [YPSticker] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    // Only For Collection View
    
    fileprivate struct Options {
        var itemSpacing: CGFloat = 10
        var lineSpacing: CGFloat = 10
        var itemsPerRow: Int = 2
        var sectionInsets: UIEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 20.0,
            bottom: 0.0,
            right: 20.0
        )
    }
    fileprivate var options = Options()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        print("Picker YP Sticker Deinit")
    }
    
    // MARK: - Methods
    
    fileprivate func configView() {
        navigationItem.title = "スタンプ選択"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.notoSansCJKJP(style: .bold, size: 15),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        configDataSource()
        // Image Current
        imageContainSticker?.contentMode = .scaleAspectFit
        imageContainSticker?.layer.cornerRadius = 10
        imageContainSticker?.clipsToBounds = true
        imageContainSticker?.image = currentlySelectedImageThumbnail ?? inputPhoto.originalImage
        imageContainSticker.isUserInteractionEnabled = true
        // Collection View
        let bundle = Bundle(for: YPPickerVC.self)
        let nib = UINib(nibName: "YPStickerCollectionViewCell", bundle: bundle)
        let seperatorNib = UINib(nibName: "YPStickerSeperatorCollectionViewCell", bundle: bundle)
        collectionView?.register(nib, forCellWithReuseIdentifier: "YPStickerCollectionViewCell")
        collectionView?.register(seperatorNib, forCellWithReuseIdentifier: "YPStickerSeperatorCollectionViewCell")
        collectionView?.alwaysBounceVertical = true
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView?.alwaysBounceVertical = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.reloadData()
        // Next Button
        setupRightBarButton()
    }
    
    fileprivate func configDataSource() {
        for (index, item) in YPConfig.stickers.enumerated() {
            dataSource.append(CustomCell(isSeperator: false, infoImage: item))
            if (index + 1) < YPConfig.stickers.count && item.photoStampType != YPConfig.stickers[index + 1].photoStampType {
                dataSource.append(CustomCell(isSeperator: true, infoImage: nil))
            }
        }
    }
    
    fileprivate func setupRightBarButton() {
        let rightBarButtonTitle = YPConfig.wordings.next
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightBarButtonTitle,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(nextAction))
        navigationItem.rightBarButtonItem?.tintColor = YPConfig.colors.tintColor
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [NSAttributedString.Key.font : UIFont.notoSansCJKJP(style: .bold, size: 14)],
            for: .normal)
    }
    
    @objc func nextAction() {
        guard let didSave = didSave else { return print("Don't have saveCallback") }
        let bundle = Bundle(for: YPImagePicker.self)
        let ypFinishVC = YPFinishVC(nibName: "YPFinishVC", bundle: bundle)
        self.inputPhoto.modifiedImage = UIImage.imageWithView(imageContainSticker)
        ypFinishVC.didSave = didSave
        ypFinishVC.didCancel = didCancel
        ypFinishVC.inputPhoto = inputPhoto
        ypFinishVC.selectedFilter = selectedFilter
        ypFinishVC.currentlySelectedImageThumbnail = UIImage.imageWithView(imageContainSticker)
        navigationController?.pushViewController(ypFinishVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension YPStickersVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        let selectedObject = dataSource[indexPath.row]
        if selectedObject.isSeperator {
            if let cellInfo = collectionView.dequeueReusableCell(
                withReuseIdentifier: "YPStickerSeperatorCollectionViewCell",
                for: indexPath) as? YPStickerSeperatorCollectionViewCell {
                cell = cellInfo
            }
        } else {
            if let selectedSticker = selectedObject.infoImage {
                let isAlreadyChoice = choiceStickers.firstIndex(where: { $0.id == selectedSticker.id }) != nil ? true : false
                if let cellInfo = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "YPStickerCollectionViewCell",
                    for: indexPath) as? YPStickerCollectionViewCell {
                    cellInfo.configData(ypSticker: selectedSticker, isAlreadyChoice: isAlreadyChoice)
                    cell = cellInfo
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedObject = dataSource[indexPath.row]
        guard !selectedObject.isSeperator else { return }
        if !dataSource[indexPath.row].isSeperator {
            if let selectedSticker = dataSource[indexPath.row].infoImage {
                if let alreadyChoiceIndex = choiceStickers.firstIndex(where: { $0.id == selectedSticker.id }) {
                    choiceStickers.remove(at: alreadyChoiceIndex)
                    deleteImageInView(id: selectedSticker.id)
                } else {
                    guard let stickerUrl = selectedSticker.imageUrl else { return }
                    if choiceStickers.count == 0 {
                        choiceStickers.append(selectedSticker)
                        DownloadHelpers.downloadImage(url: stickerUrl) { [weak self, selectedSticker] (image) in
                            let imageView = UIImageView(image: image)
                            imageView.tag = selectedSticker.id
                            self?.didSelectImage(imageView: imageView)
                        }
                    } else {
                        if let alreadyTypeIndex = choiceStickers.firstIndex(where: { $0.photoStampType == selectedSticker.photoStampType }) {
                            DownloadHelpers.downloadImage(url: stickerUrl) { [weak self, selectedSticker] (image) in
                                let imageView = UIImageView(image: image)
                                imageView.tag = selectedSticker.id
                                self?.didSelectImage(imageView: imageView)
                            }
                            deleteImageInView(id: choiceStickers[alreadyTypeIndex].id)
                            choiceStickers.remove(at: alreadyTypeIndex)
                            choiceStickers.append(selectedSticker)
                        } else {
                            choiceStickers.append(selectedSticker)
                            DownloadHelpers.downloadImage(url: stickerUrl) { [weak self, selectedSticker] (image) in
                                let imageView = UIImageView(image: image)
                                imageView.tag = selectedSticker.id
                                self?.didSelectImage(imageView: imageView)
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension YPStickersVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightPerItem: CGFloat = 150.0
        let selectedObject = dataSource[indexPath.row]
        if selectedObject.isSeperator {
            return CGSize(width: 15, height: heightPerItem)

        } else {
            return CGSize(width: 90.0, height: heightPerItem)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return options.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return options.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return options.itemSpacing
    }
}
