//
//  BoardViewCell.swift
//  GoodBoard
//
//  Created by Saul Hamadani on 7/24/20.
//  Copyright © 2020 Saul Hamadani. All rights reserved.
//

import Foundation
import UIKit


class BoardViewCell: UICollectionViewCell {
    fileprivate let imageView = UIImageView()
    fileprivate let titleLabel = UILabel()
    fileprivate let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) { return nil }
}

private extension BoardViewCell {
    func commonInit() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.masksToBounds = true
        
        //configure title label
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        self.titleLabel.textColor = .black
        self.titleLabel.textAlignment = .left
        
        //configure subtitle label
        self.subtitleLabel.numberOfLines = 0
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
        self.subtitleLabel.textColor = .gray
        self.subtitleLabel.textAlignment = .left
        
        //add subviews
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subtitleLabel)
        
        //create constraints
        let views = ["image" : self.imageView,
                     "title" : self.titleLabel,
                     "subtitle" : self.subtitleLabel]
        let imageConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|[image(==\(UIScreen.main.bounds.width-32))]|", options: [], metrics: nil, views: views)
        let imageConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|[image]", options: [], metrics: nil, views: views)
        let titleConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[title]-16-|", options: [], metrics: nil, views: views)
        let titleConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:[image]-16-[title]", options: [], metrics: nil, views: views)
        let subtitleConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[subtitle]-16-|", options: [], metrics: nil, views: views)
        let subtitleConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:[title]-8-[subtitle]-16-|", options: [], metrics: nil, views: views)
        
        //add constraints
        self.contentView.addConstraints(imageConstraintsH + imageConstraintsV)
        self.contentView.addConstraints(titleConstraintsH + titleConstraintsV)
        self.contentView.addConstraints(subtitleConstraintsH + subtitleConstraintsV)
    }
}

extension BoardViewCell { //appearance
    func configure(image: UIImage) {
        self.imageView.image = image
    }
    
    func configure(subtitle: String) {
        self.subtitleLabel.text = subtitle
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
}
