//
//  TheFantasy.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class The_Fantasy: Queen {
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "The_Fantasy"
        self.cost = PieceCosts[self.type]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectMove() {
        super.collectMove()
    }
    
    override func gameStartManner() {
        super.gameStartManner()
    }
    override func gameStartEffect() {
        var posibleSquare = [Square]()
        let len = (boardUpperBound.rank) / 4
        var startRank=0
        var color = ""
        if self.belong == 0 {
            color = "White"
            startRank = boardUpperBound.rank - len
        } else if self.belong == 1 {
            color = "Black"
            startRank = boardLowerBound.rank
        }
        
        let endRank = startRank + len
        for rank in startRank...endRank {
            for file in boardLowerBound.file...boardUpperBound.file {
                let coord = ChessboardCoordinate(rank: rank, file: file)
                let square = GameManager.board.getSquare(coord)
                posibleSquare.append(square)
            }
        }
        let number = Int(arc4random()) % posibleSquare.count
        let texture = SKTexture(imageNamed: "\(color)_Fantasy_Square")
        let effect = FantasySquare(belong: self.belong, texture: texture, size: self.size)
        
        posibleSquare[number].addChild(effect)
    }
}
