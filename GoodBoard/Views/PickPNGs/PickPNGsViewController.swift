//
//  PickPNGsViewController.swift
//  GoodBoard
//
//  Created by Kareem Sabri on 7/25/20.
//  Copyright © 2020 Saul Hamadani. All rights reserved.
//

import Foundation
import UIKit

protocol PickPNGsViewControllerDelegate {
    func didPickPNGs(images: [UIImage])
}

fileprivate extension Selector {
    static let addToBoardTapped =
        #selector(PickPNGsViewController.addToBoardTapped(_:))
}

class PickPNGsViewController: UIViewController {
    fileprivate let numImages = 9 //this must match the number of images in the xcassets with names PNGs 1-n
    fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    fileprivate let titleLabel = UILabel()
    fileprivate let addToBoardButton = UIButton()
    
    var delegate: PickPNGsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.titleLabel.text = "Select PNGs"
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.titleLabel)
        
        self.collectionView.backgroundColor = .white
        self.collectionView.allowsMultipleSelection = true
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(PNGCell.self, forCellWithReuseIdentifier: "pngCell")
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 20
        self.view.addSubview(self.collectionView)
        
        self.addToBoardButton.translatesAutoresizingMaskIntoConstraints = false
        self.addToBoardButton.setTitle("+ Add to Board", for: .normal)
        self.addToBoardButton.backgroundColor = .gray
        self.addToBoardButton.layer.cornerRadius = 25.0
        self.addToBoardButton.layer.masksToBounds = true
        self.addToBoardButton.setTitleColor(.white, for: .normal)
        self.addToBoardButton.isEnabled = false
        self.addToBoardButton.addTarget(self, action: .addToBoardTapped, for: .touchUpInside)
        self.view.addSubview(self.addToBoardButton)
        
        let views = ["title": self.titleLabel, "collection": self.collectionView, "button": self.addToBoardButton]
        let titleConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[title]-16-|", options: [], metrics: nil, views: views)
        let titleConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[title]", options: [], metrics: nil, views: views)
        let collectionConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[collection]-16-|", options: [], metrics: nil, views: views)
        let collectionConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:[title]-16-[collection]-16-[button]", options: [], metrics: nil, views: views)
        let buttonConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[button]-16-|", options: [], metrics: nil, views: views)
        let buttonConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:[button(50)]-48-|", options: [], metrics: nil, views: views)
        self.view.addConstraints(titleConstraintsH + titleConstraintsV)
        self.view.addConstraints(collectionConstraintsH + collectionConstraintsV)
        self.view.addConstraints(buttonConstraintsH + buttonConstraintsV)
    }
    
    @objc func addToBoardTapped(_: UIButton) {
        if let paths = self.collectionView.indexPathsForSelectedItems {
            if paths.count > 0 {
                let images = paths.map { (path: IndexPath) -> UIImage in
                    let cell = self.collectionView.cellForItem(at: path) as! PNGCell
                    return cell.imageView.image!
                }
                
                self.delegate?.didPickPNGs(images: images)
            }
        }
    }
}

extension PickPNGsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PNGCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pngCell", for: indexPath) as! PNGCell
        
        let idx = indexPath.row + 1
        let name = "PNG\(idx)"
        let image = UIImage(named: name)!
        
        cell.configure(image: image)
        
        return cell
    }
}

extension PickPNGsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: PNGCell = collectionView.cellForItem(at: indexPath) as! PNGCell
        cell.configure(selected: true)
        self.addToBoardButton.isEnabled = true
        self.addToBoardButton.backgroundColor = .black
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell: PNGCell = collectionView.cellForItem(at: indexPath) as! PNGCell
        cell.configure(selected: false)
        if let items = collectionView.indexPathsForSelectedItems {
            if items.count > 0 {
                return
            }
        }
        self.addToBoardButton.isEnabled = false
        self.addToBoardButton.backgroundColor = .gray
    }
}
