//
//  CreateBoardViewController.swift
//  GoodBoard
//
//  Created by Saul Hamadani on 7/24/20.
//  Copyright © 2020 Saul Hamadani. All rights reserved.
//

import Foundation
import UIKit

class CreateBoardViewController: UIViewController {
    fileprivate let boardBackground = UIView()
    fileprivate let addPNGsButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        //configure board background
        self.boardBackground.backgroundColor = .white
        
        //configure add PNGs button
        self.addPNGsButton.backgroundColor = .white
        self.addPNGsButton.layer.cornerRadius = 25.0
        self.addPNGsButton.layer.masksToBounds = true
        self.addPNGsButton.setTitle("Add PNGs", for: .normal)
        self.addPNGsButton.setTitleColor(.black, for: .normal)
        self.addPNGsButton.addTarget(self, action: #selector(CreateBoardViewController.handleAddPNGs), for: .touchUpInside)
        
        //add subviews
        self.boardBackground.translatesAutoresizingMaskIntoConstraints = false
        self.addPNGsButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.boardBackground)
        self.view.addSubview(self.addPNGsButton)
        
        //create constraints
        let views = ["button" : self.addPNGsButton]
        let boardConstraintsH = [NSLayoutConstraint(item: self.boardBackground, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0)]
        let boardConstraintsV = [NSLayoutConstraint(item: self.boardBackground, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0),
                                 NSLayoutConstraint(item: self.boardBackground, attribute: .width, relatedBy: .equal, toItem: self.boardBackground, attribute: .height, multiplier: 1.0, constant: 0.0)]
        let addButtonConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[button]-16-|", options: [], metrics: nil, views: views)
        let addButtonConstraintsV = [NSLayoutConstraint(item: self.addPNGsButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0),
                                     NSLayoutConstraint(item: self.addPNGsButton, attribute: .bottomMargin, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: -16.0)]

        //add constaints
        self.view.addConstraints(boardConstraintsH + boardConstraintsV)
        self.view.addConstraints(addButtonConstraintsH + addButtonConstraintsV)
    }
}

extension CreateBoardViewController {
    @objc func handleAddPNGs() {
        let imagePicker = UIImagePickerController()
        self.present(imagePicker, animated: true)
    }
}
