//
//  RoseQueen.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class Rose_Queen: Queen {
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "Rose_Queen"
        self.cost = PieceCosts[self.type]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func dieManner() {
        super.dieManner()
        
        var resurrectionSquares = [Square]()
        
        for rank in boardLowerBound.rank...boardUpperBound.rank {
            for file in boardLowerBound.file...boardUpperBound.file {
                let coord = ChessboardCoordinate(rank: rank, file: file)
                let square = GameManager.board.getSquare(coord)
                if let piece = square.piece {
                    if piece is Rose_Garden_Guard && piece.belong == self.belong {
                        resurrectionSquares.append(square)
                    }
                }
            }
        }
        if !resurrectionSquares.isEmpty {
            GameManager.touchLock += 1
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                let number = Int(arc4random()) % resurrectionSquares.count
                let pawn = resurrectionSquares[number].piece!
                pawn.removeFromParent()
                
                self.currentSquare = resurrectionSquares[number]
                resurrectionSquares[number].hasPiece = true
                resurrectionSquares[number].piece! = self
                resurrectionSquares[number].addChild(self)
                
                GameManager.touchLock -= 1
            }
        }
    }
    
    
    override func collectMove() {
        super.collectMove()
    }
}
