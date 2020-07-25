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
    fileprivate let viewCountLabel = UILabel()
    fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    fileprivate let addNewButton = UIButton()
    fileprivate var boards = [Board(id: 1), Board(id: 2), Board(id: 3)]
    fileprivate let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Goodmood"
        
        self.view.backgroundColor = .white
        
        self.titleLabel.text = "sweetcreaturep"
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.titleLabel.textAlignment = .left
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.titleLabel)
        
        self.viewCountLabel.text = "23.7K saves"
        self.viewCountLabel.textColor = .lightGray
        self.viewCountLabel.font = UIFont.systemFont(ofSize: 14)
        self.viewCountLabel.textAlignment = .left
        self.viewCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.viewCountLabel)
        
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
        
        self.addNewButton.backgroundColor = .black
        self.addNewButton.setTitle("+", for: .normal)
        self.addNewButton.setTitleColor(.white, for: .normal)
        self.addNewButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 48)
        self.addNewButton.translatesAutoresizingMaskIntoConstraints = false
        self.addNewButton.layer.cornerRadius = 10
        self.addNewButton.addTarget(self, action: #selector(BoardsViewController.newButtonTapped), for: .touchUpInside)
        self.view.addSubview(self.addNewButton)
        self.addNewButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        //add constraints
        let views = ["collection": self.collectionView, "title": self.titleLabel, "viewCount": self.viewCountLabel, "button": self.addNewButton]
        let titleConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[title]|", options: [], metrics: nil, views: views)
        let titleConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-120-[title]", options: [], metrics: nil, views: views)
        let viewCountConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[viewCount]|", options: [], metrics: nil, views: views)
        let viewCountConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:[title]-10-[viewCount]", options: [], metrics: nil, views: views)
        
        let collectionConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[collection]-16-|", options: [], metrics: nil, views: views)
        let collectionConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:[viewCount]-10-[collection]|", options: [], metrics: nil, views: views)
        let buttonConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:[button]-40-|", options: [], metrics: nil, views: views)
        let buttonConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: "[button(60)]", options: [], metrics: nil, views: views)
        self.view.addConstraints(titleConstraintsH + titleConstraintsV)
        self.view.addConstraints(viewCountConstraintsH + viewCountConstraintsV)
        self.view.addConstraints(collectionConstraintsH + collectionConstraintsV)
        self.view.addConstraints(buttonConstraintsH + buttonConstraintsV)
    }
    
    @objc func newButtonTapped() {
        self.performSegue(withIdentifier: "createBoardSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createBoardSegue" {
            let createBoardViewController = segue.destination as! CreateBoardViewController
            let board = Board(id: self.boards.count + 1)
            createBoardViewController.board = board
            createBoardViewController.delegate = self
        }
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
        if let imageName = board.imageName {
            let filename = getDocumentsDirectory().appendingPathComponent(imageName)
            if let image = UIImage(contentsOfFile: filename.path) {
                cell.configure(image: image)
            }
        } else {
            cell.configure(image: UIImage(named: "Board")!)
        }
        cell.configure(title: board.title)
        cell.configure(subtitle: "Created \(self.formatter.string(from: board.createdAt))")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete Board", style: .destructive) { _ in
            self.boards.remove(at: indexPath.row)
            self.collectionView.reloadData()
        }
        let renameAction = UIAlertAction(title: "Rename Board", style: .default) { _ in
            let rename = UIAlertController(title: "Rename Board", message: "Please enter a name for your board.", preferredStyle: .alert)
            rename.addTextField { (textField) in
                textField.placeholder = "Name"
            }
            
            let renameButton = UIAlertAction(title: "Rename", style: .default) { _ in
                self.boards[indexPath.row].title = rename.textFields?.first?.text ?? "You're crushin' it!"
                self.collectionView.reloadData()
            }
            
            rename.addAction(renameButton)
            
            self.present(rename, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        sheet.addAction(renameAction)
        sheet.addAction(deleteAction)
        sheet.addAction(cancelAction)
        self.present(sheet, animated: true, completion: nil)
    }
    
    fileprivate func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension BoardsViewController: CreateBoardViewControllerDelegate {
    func didSaveBoard(board: Board) {
        if let index = self.boards.firstIndex(where: { $0.id == board.id }) {
            self.boards[index] = board
        } else {
            self.boards.insert(board, at: 0)
        }
        self.collectionView.reloadData()
    }
}
