//
//  Board.swift
//  GoodBoard
//
//  Created by Saul Hamadani on 7/24/20.
//  Copyright © 2020 Saul Hamadani. All rights reserved.
//

import Foundation

class Board {
    var imageUrl: URL?
    var title: String
    var createdAt: Date
    
    init(imageUrl: URL, title: String = "Untitled") {
        self.imageUrl = imageUrl
        self.title = title
        self.createdAt = Date()
    }
    
    init() {
        self.imageUrl = URL(string: "https://unsplash.com/photos/tTO-0qAo65w")
        self.title = "I'm a board"
        self.createdAt = Date()
    }
}
