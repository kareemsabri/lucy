//
//  BoardsViewController.swift
//  GoodBoard
//
//  Created by Saul Hamadani on 7/24/20.
//  Copyright © 2020 Saul Hamadani. All rights reserved.
//

import Foundation
import UIKit

class BoardsViewController: UIViewController {
    fileprivate let titleLabel = UILabel()
    fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    fileprivate let boards = [Board(), Board(), Board()]
    fileprivate let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.titleLabel.text = "Goodmood"
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        self.titleLabel.textAlignment = .center
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.titleLabel)
        
        self.formatter.dateStyle = .medium
        self.collectionView.backgroundColor = .white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(BoardViewCell.self, forCellWithReuseIdentifier: "boardCell")
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 100)
        layout.minimumLineSpacing = 40
        
        self.collectionView.collectionViewLayout = layout
        //add constraints
        let views = ["collection": self.collectionView, "title": self.titleLabel]
        let titleConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|[title]|", options: [], metrics: nil, views: views)
        let titleConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[title]", options: [], metrics: nil, views: views)
        let collectionConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[collection]-16-|", options: [], metrics: nil, views: views)
        let collectionConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:[title]-8-[collection]|", options: [], metrics: nil, views: views)
        self.view.addConstraints(titleConstraintsH + titleConstraintsV)
        self.view.addConstraints(collectionConstraintsH + collectionConstraintsV)
    }
}

extension BoardsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BoardViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardCell", for: indexPath) as! BoardViewCell
        
        let board = self.boards[indexPath.item]
        let image = UIImage(named: "Board")!
        cell.configure(image: image)
        cell.configure(title: board.title)
        cell.configure(subtitle: "Created \(self.formatter.string(from: board.createdAt))")
        return cell
    }
}
