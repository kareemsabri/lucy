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
        self.lastSavedLabel.text = "Last saved \(self.formatter.string(from: self.board.updatedAt))"
        self.delegate?.didSaveBoard(board: self.board)
    }
    
    fileprivate func save() {
        let now = Date()
        
        UIGraphicsBeginImageContextWithOptions(self.boardBackground.bounds.size, false, UIScreen.main.scale)
        self.boardBackground.drawHierarchy(in: self.boardBackground.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.board.updatedAt = now
        
        if let data = image?.pngData() {
            let imageName = "\(self.board.id).png"
            let filename = getDocumentsDirectory().appendingPathComponent(imageName)
            do {
                try data.write(to: filename)
                self.board.imageName = imageName
            } catch {
                print("unable to save")
            }
        }
        
        self.didSave()
    }
    
    fileprivate func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}

extension CreateBoardViewController {
    @objc func handleAddPNGs() {
        let pickPNGsViewController = PickPNGsViewController()
        pickPNGsViewController.delegate = self
        self.present(pickPNGsViewController, animated: true)
    }
}

extension CreateBoardViewController {
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        guard let senderView = sender.view else { return }
        
        senderView.center = CGPoint(x: senderView.center.x + translation.x, y: senderView.center.y + translation.y)

        sender.setTranslation(.zero, in: view)
        
        if sender.state == .ended {
            self.save()
        }
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        guard let senderView = sender.view else { return }
        senderView.transform = senderView.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
        if sender.state == .ended {
            self.save()
        }
    }
    
    @objc func handleRotate(_ sender: UIRotationGestureRecognizer) {
        guard let senderView = sender.view else { return }
        senderView.transform = senderView.transform.rotated(by: sender.rotation)
        sender.rotation = 0
        if sender.state == .ended {
            self.save()
        }
    }
    
    @objc func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        guard let senderView = sender.view else { return }
        guard let index = self.boardBackground.subviews.firstIndex(where: { $0 == senderView }), index > 0 else { return }
        senderView.removeFromSuperview()
        self.boardBackground.insertSubview(senderView, at: index - 1)
        if sender.state == .ended {
            self.save()
        }
    }
}

extension CreateBoardViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension CreateBoardViewController: PickPNGsViewControllerDelegate {
    func didPickPNGs(images: [UIImage]) {
        images.forEach {
            let imageView = UIImageView(image: $0)
            imageView.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(CreateBoardViewController.handlePan(_:)))
            panGesture.delegate = self
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateBoardViewController.handleDoubleTap(_:)))
            tapGesture.delegate = self
            tapGesture.numberOfTapsRequired = 2
            	
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(CreateBoardViewController.handlePinch(_:)))
            pinchGesture.delegate = self

            let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(CreateBoardViewController.handleRotate(_:)))
            rotateGesture.delegate = self
            
            imageView.addGestureRecognizer(tapGesture)
            imageView.addGestureRecognizer(panGesture)
            imageView.addGestureRecognizer(pinchGesture)
            imageView.addGestureRecognizer(rotateGesture)
            self.boardBackground.addSubview(imageView)
        }
        self.dismiss(animated: true)
        self.save()
    }
}
