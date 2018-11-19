//
//  YPFilterCollectionViewCell.swift
//  photoTaking
//
//  Created by Sacha Durand Saint Omer on 21/10/16.
//  Copyright © 2016 octopepper. All rights reserved.
//

import Stevia

class YPFilterCollectionViewCell: UICollectionViewCell {
    
    let name = UILabel()
    let imageView = UIImageView()
    override var isHighlighted: Bool { didSet {
        UIView.animate(withDuration: 0.1) {
            self.contentView.transform = self.isHighlighted
                ? CGAffineTransform(scaleX: 0.95, y: 0.95)
                : CGAffineTransform.identity
            }
        }
    }
    override var isSelected: Bool { didSet {
        name.textColor = isSelected
            ? UIColor(r: 87, g: 195, b: 232)
            : UIColor(r: 36, g: 36, b: 36)
        
        name.font = .systemFont(ofSize: 13, weight: isSelected
            ? UIFont.Weight.regular
            : UIFont.Weight.regular)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sv(
            name,
            imageView
        )
        
        |name|.top(0)
        |imageView|.bottom(0).heightEqualsWidth()
        
        name.font = .systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        name.textColor = UIColor(r: 36, g: 36, b: 36)
        name.textAlignment = .center
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.clear
        imageView.layer.cornerRadius = 4
        
        self.clipsToBounds = false
        // TODO: QuangTT Custom - Disable Shadow Color
//        self.layer.shadowColor = UIColor(r: 46, g: 43, b: 37).cgColor
//        self.layer.shadowOpacity = 0.2
//        self.layer.shadowOffset = CGSize(width: 4, height: 7)
//        self.layer.shadowRadius = 5
        self.layer.backgroundColor = UIColor.clear.cgColor
    }
}
