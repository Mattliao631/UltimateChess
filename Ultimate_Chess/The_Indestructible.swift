//
//  TheIndestructible.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class The_Indestructible: Rook {
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "The_Indestructible"
        self.cost = PieceCosts[self.type]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectMove() {
        super.collectMove()
    }
    
    override func move(square: Square) {
        super.move(square: square)
        let directions = [
            ChessboardCoordinate(rank: 1, file: 0),
            ChessboardCoordinate(rank: -1, file: 0),
            ChessboardCoordinate(rank: 0, file: 1),
            ChessboardCoordinate(rank: 0, file: -1)
        ]
        for direction in directions {
            let coord = self.currentSquare!.boardCoordinate+direction
            if boundCheck(coord) {
                if let piece = GameManager.board.getSquare(coord).piece {
                    if piece.belong == self.belong {
                        piece.takable = false
                    }
                }
            }
        }
        self.takable=false
    }
}
