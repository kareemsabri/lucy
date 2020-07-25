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
    var title: String
    var createdAt: Date
    var updatedAt: Date
    
    static var defaultBoards: [Board] = [
        Board(id: 1, imageName: "Board1", title: "The Main Character"),
        Board(id: 2, imageName: "Board2", title: "Bittersweet summertime"),
        Board(id: 3, imageName: "Board3", title: "I'm coming out"),
        Board(id: 4, imageName: "Board4", title: "the 1970s"),
        Board(id: 5, imageName: "Board5", title: "Peach with an e"),
    ]
    
    init(id: Int, imageName: String? = nil, title: String = "Untitled") {
        self.id = id
        self.title = title
        self.imageName = imageName
        self.createdAt = Date()
        self.updatedAt = self.createdAt
    }
}

