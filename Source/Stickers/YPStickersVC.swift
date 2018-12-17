//
//  YPStickersVC.swift
//  YPImagePicker
//
//  Created by Quang on 12/17/18.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import UIKit

class YPStickersVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
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
        // Image Current
        imageView?.contentMode = .scaleAspectFit
        imageView?.layer.cornerRadius = 10
        imageView?.clipsToBounds = true
        imageView?.image = currentlySelectedImageThumbnail ?? inputPhoto.originalImage
        // Collection View
        let bundle = Bundle(for: YPPickerVC.self)
        let nib = UINib(nibName: "YPStickerCollectionViewCell", bundle: bundle)
        collectionView?.register(nib, forCellWithReuseIdentifier: "YPStickerCollectionViewCell")
        collectionView?.alwaysBounceVertical = true
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView?.alwaysBounceVertical = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.reloadData()
        // Next Button
        setupRightBarButton()
    }
    
    fileprivate func setupRightBarButton() {
        let rightBarButtonTitle = YPConfig.wordings.next
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightBarButtonTitle,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(nextAction))
        navigationItem.rightBarButtonItem?.tintColor = YPConfig.colors.tintColor
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)],
            for: .normal)
    }
    
    @objc func nextAction() {
        guard let didSave = didSave else { return print("Don't have saveCallback") }
        self.navigationItem.rightBarButtonItem = YPLoaders.defaultLoader
        let bundle = Bundle(for: YPImagePicker.self)
        let ypFinishVC = YPFinishVC(nibName: "YPFinishVC", bundle: bundle)
        ypFinishVC.didSave = didSave
        ypFinishVC.didCancel = didCancel
        ypFinishVC.inputPhoto = inputPhoto
        ypFinishVC.selectedFilter = selectedFilter
        ypFinishVC.currentlySelectedImageThumbnail = currentlySelectedImageThumbnail
        navigationController?.pushViewController(ypFinishVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension YPStickersVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return YPConfig.stickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let selectedSticker = YPConfig.stickers[indexPath.row]
        let isAlreadyChoice = choiceStickers.firstIndex(where: { $0.id == selectedSticker.id }) != nil ? true : false
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "YPStickerCollectionViewCell",
            for: indexPath) as? YPStickerCollectionViewCell {
            cell.configData(ypSticker: selectedSticker, isAlreadyChoice: isAlreadyChoice)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSticker = YPConfig.stickers[indexPath.row]
        if let alreadyChoiceIndex = choiceStickers.firstIndex(where: { $0.id == selectedSticker.id }) {
            choiceStickers.remove(at: alreadyChoiceIndex)
        } else {
            choiceStickers.append(selectedSticker)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension YPStickersVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem: CGFloat = 90.0
        let heightPerItem: CGFloat = 150.0
        return CGSize(width: widthPerItem, height: heightPerItem)
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
