//
//  PNGCell.swift
//  GoodBoard
//
//  Created by Kareem Sabri on 7/25/20.
//  Copyright © 2020 Saul Hamadani. All rights reserved.
//

import Foundation
import UIKit

class PNGCell: UICollectionViewCell {
    fileprivate let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) { return nil }
}

private extension PNGCell {
    func commonInit() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.masksToBounds = true
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.imageView)
        
        //constraints
        let views = ["image": self.imageView]
        let imageConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(100)]-|", options: [], metrics: nil, views: views)
        let imageConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(100)]-|", options: [], metrics: nil, views: views)
        self.contentView.addConstraints(imageConstraintsH + imageConstraintsV)
    }
}

extension PNGCell { //appearance
    func configure(image: UIImage) {
        self.imageView.image = image
    }
}
