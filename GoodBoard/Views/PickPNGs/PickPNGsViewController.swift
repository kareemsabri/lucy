//
//  PickPNGsViewController.swift
//  GoodBoard
//
//  Created by Kareem Sabri on 7/25/20.
//  Copyright © 2020 Saul Hamadani. All rights reserved.
//

import Foundation
import UIKit

class PickPNGsViewController: UIViewController {
    fileprivate let numImages = 9 //this must match the number of images in the xcassets with names PNGs 1-n
    fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.collectionView.backgroundColor = .green
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(PNGCell.self, forCellWithReuseIdentifier: "pngCell")
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 20
        self.view.addSubview(self.collectionView)
        
        
//        for i in 1...9 {
//            let name = "PNG\(i)"
//            let image = UIImage(named: name)
//            let imageView = UIImageView(image: image)
//            self.view.addSubview(imageView)
//        }
        
        let views = ["collection": self.collectionView]
        let collectionConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[collection]-16-|", options: [], metrics: nil, views: views)
        let collectionConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[collection]-16-|", options: [], metrics: nil, views: views)
        self.view.addConstraints(collectionConstraintsH + collectionConstraintsV)
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
}
