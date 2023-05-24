//
//  SpaceGrimoire.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class Space_Grimoire: Bishop {
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "Space_Grimoire"
        self.cost = 7
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectMove() {
        self.movableSquares = []
        self.takableSquares = []
        SpaceGrimoireMove(piece: self, board: parent?.parent as! Board)
    }
}
