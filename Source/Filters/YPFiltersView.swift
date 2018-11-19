//
//  YPFiltersView.swift
//  photoTaking
//
//  Created by Sacha Durand Saint Omer on 21/10/16.
//  Copyright © 2016 octopepper. All rights reserved.
//

import Stevia

class YPFiltersView: UIView {
    
    let imageView = UIImageView()
    var collectionView: UICollectionView!
    var filtersLoader: UIActivityIndicatorView!
    fileprivate let collectionViewContainer: UIView = UIView()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout())
        filtersLoader = UIActivityIndicatorView(style: .gray)
        filtersLoader.hidesWhenStopped = true
        filtersLoader.startAnimating()
        filtersLoader.color = YPConfig.colors.tintColor
        
        sv(
            imageView,
            collectionViewContainer.sv(
                filtersLoader,
                collectionView
            )
        )
        
        let isIphone4 = UIScreen.main.bounds.height == 480
//        let sideMargin: CGFloat = isIphone4 ? 20 : 0
        let sideMargin: CGFloat = 20
        
        |-sideMargin-imageView.top(20)-sideMargin-|
        imageView.Bottom == collectionViewContainer.Top - 20
        |-0.0-collectionViewContainer-0.0-|
        collectionViewContainer.bottom(0)
        
        // TODO: QuangTT Custom
//        |collectionView.centerVertically().height(160)|
        |collectionView.top(10).height(140)|
//        filtersLoader.centerInContainer()
        filtersLoader.top(20)
        filtersLoader.centerHorizontally()
        
        collectionViewContainer.backgroundColor = UIColor(r: 248, g: 250, b: 251)
        imageView.heightEqualsWidth()
        imageView.layer.cornerRadius = 8
        
        backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 100, height: 125)
        return layout
    }
}
