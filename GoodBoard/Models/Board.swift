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
    
    init(imageUrl: URL, title: String = "Untitled") {
        self.imageUrl = imageUrl
        self.title = title
    }
}
