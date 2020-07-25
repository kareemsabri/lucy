//
//  CreateBoardTitleView.swift
//  GoodBoard
//
//  Created by Saul Hamadani on 7/24/20.
//  Copyright © 2020 Saul Hamadani. All rights reserved.
//

import UIKit

class CreateBoardTitleView: UIView {
    fileprivate let titleLabel = UILabel()
    fileprivate let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) { return nil }
}

extension CreateBoardTitleView {
    func commonInit() {
        self.titleLabel.text = "asdlfknsadf"
        self.titleLabel.textColor = .white
        self.titleLabel.font = .systemFont(ofSize: 15.0)
        
        self.subtitleLabel.textColor = .white
        self.subtitleLabel.font = .systemFont(ofSize: 12.0)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)
        
        let views = ["title" : self.titleLabel,
                     "subtitle" : self.subtitleLabel]
        let titleConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|[title]|", options: [], metrics: nil, views: views)
        let titleConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|[title]", options: [], metrics: nil, views: views)
        let subtitleConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|[subtitle]|", options: [], metrics: nil, views: views)
        let subtitleConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:[title]-8-[subtitle]-8-|", options: [], metrics: nil, views: views)
        
        self.addConstraints(titleConstraintsH + titleConstraintsV)
        self.addConstraints(subtitleConstraintsH + subtitleConstraintsV)
    }
}
