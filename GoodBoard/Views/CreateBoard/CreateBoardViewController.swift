//
//  CreateBoardViewController.swift
//  GoodBoard
//
//  Created by Saul Hamadani on 7/24/20.
//  Copyright © 2020 Saul Hamadani. All rights reserved.
//

import Foundation
import UIKit

protocol CreateBoardViewControllerDelegate {
    func didSaveBoard(board: Board)
}

class CreateBoardViewController: UIViewController {
    var board: Board!
    fileprivate let boardBackground = UIView()
    fileprivate let lastSavedLabel = UILabel()
    fileprivate let addPNGsButton = UIButton(type: .system)
    fileprivate let formatter = DateFormatter()
    
    var delegate: CreateBoardViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.formatter.dateFormat = "h:mm a"
        //configure board background
        self.boardBackground.backgroundColor = .white
        self.boardBackground.layer.masksToBounds = true
        
        self.lastSavedLabel.translatesAutoresizingMaskIntoConstraints = false
        self.lastSavedLabel.text = "Last saved just now"
        self.lastSavedLabel.textColor = .lightText
        self.lastSavedLabel.font = UIFont.systemFont(ofSize: 12)
        self.lastSavedLabel.textAlignment = .left
        
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
        self.view.addSubview(self.lastSavedLabel)
        self.view.addSubview(self.addPNGsButton)
        
        //create constraints
        let views = ["button" : self.addPNGsButton, "lastSaved": self.lastSavedLabel]
        let boardConstraintsH = [NSLayoutConstraint(item: self.boardBackground, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0)]
        let boardConstraintsV = [NSLayoutConstraint(item: self.boardBackground, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0),
                                 NSLayoutConstraint(item: self.boardBackground, attribute: .width, relatedBy: .equal, toItem: self.boardBackground, attribute: .height, multiplier: 1.0, constant: 0.0)]
        let lastSavedConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[lastSaved]-16-|", options: [], metrics: nil, views: views)
        let lastSavedConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[lastSaved]", options: [], metrics: nil, views: views)
        let addButtonConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[button]-16-|", options: [], metrics: nil, views: views)
        let addButtonConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:[button(50)]-48-|", options: [], metrics: nil, views: views)

        //add constaints
        self.view.addConstraints(boardConstraintsH + boardConstraintsV)
        self.view.addConstraints(lastSavedConstraintsH + lastSavedConstraintsV)
        self.view.addConstraints(addButtonConstraintsH + addButtonConstraintsV)
    }
    
    fileprivate func didSave() {
        let now = Date()
        self.lastSavedLabel.text = "Last saved \(self.formatter.string(from: now))"
        self.delegate!.didSaveBoard(board: self.board)
    }
}

extension CreateBoardViewController {
    @objc func handleAddPNGs() {
        let pickPNGsViewController = PickPNGsViewController()
        pickPNGsViewController.delegate = self
        self.present(pickPNGsViewController, animated: true)
    }
}

extension CreateBoardViewController: PickPNGsViewControllerDelegate {
    func didPickPNGs(images: [UIImage]) {
        images.forEach { self.boardBackground.addSubview(UIImageView(image: $0)) }
        self.dismiss(animated: true)
        self.didSave()
    }
}
