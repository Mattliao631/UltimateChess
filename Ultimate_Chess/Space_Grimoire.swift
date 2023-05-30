//
//  SpaceGrimoire.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class Space_Grimoire: Bishop {
    
    var coolDown: Int = 0
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "Space_Grimoire"
        self.cost = PieceCosts[self.type]!
        self.canMove = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func turnStartManner() {
        super.turnStartManner()
        self.coolDown-=1
        if self.coolDown<=0 {
            coolDown=0
            self.canMove = true
        }
    }
    
    override func collectMove() {
        self.movableSquares = []
        self.takableSquares = []
        SpaceGrimoireMove(piece: self, board: parent?.parent as! Board)
        self.coolDown=3
        self.canMove=false
    }
    
}
