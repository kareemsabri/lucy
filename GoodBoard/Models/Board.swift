//
//  Board.swift
//  GoodBoard
//
//  Created by Saul Hamadani on 7/24/20.
//  Copyright © 2020 Saul Hamadani. All rights reserved.
//

import Foundation

class Board {
    var id: Int
    var imageName: String?
    var imageUrl: URL?
    var title: String
    var createdAt: Date
    
    init(id: Int, imageUrl: URL, title: String = "Untitled") {
        self.id = id
        self.imageUrl = imageUrl
        self.title = title
        self.createdAt = Date()
    }
    
    init(id: Int) {
        self.id = id
        self.imageUrl = URL(string: "https://unsplash.com/photos/tTO-0qAo65w")
        self.title = "I'm a board"
        self.createdAt = Date()
    }
}
