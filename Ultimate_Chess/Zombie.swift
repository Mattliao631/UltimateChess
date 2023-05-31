//
//  Zombie.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit

class Zombie: Pawn {
    
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "Zombie"
        self.cost = PieceCosts[self.type]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectMove() {
        super.collectMove()
    }
    
    override func take(square: Square) {
        if let piece = square.piece {
            if piece is Zombie {
                super.take(square: square)
            } else {
                
                // remove the piece being captured
                let takenPiece = square.piece!
                takenPiece.removeFromParent()
                square.hasPiece = false
                square.piece = nil
                
                let newZombie = Zombie(belong: self.belong, texture: self.texture!, square: square)
                square.hasPiece=true
                square.piece = newZombie
                square.addChild(newZombie)
                
                self.moved = true
                //print(piece.position)
                takenPiece.dieManner()
            }
        }
    }
}
