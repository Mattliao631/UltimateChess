//
//  DivineBlessed.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class Divine_Blessed: Bishop {
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "Divine_Blessed"
        self.cost = PieceCosts[self.type]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateClone() {
        var availableSquares = [Square]()
        let direction = [
            ChessboardCoordinate(rank: 1, file: 0),
            ChessboardCoordinate(rank: -1, file: 0),
            ChessboardCoordinate(rank: 0, file: 1),
            ChessboardCoordinate(rank: 0, file: -1)
        ]
        for i in 0...3 {
            let coordinate = self.currentSquare!.boardCoordinate+direction[i]
            if boundCheck(coordinate) {
                let square = GameManager.board.getSquare(coordinate)
                availableSquares.append(square)
            }
        }
        let s = Int(arc4random() % 4)
        var i = 0
        var generated = false
        while !generated {
            let square = availableSquares[(s+i)%availableSquares.count]
            if !square.hasPiece {
                let piece = Divine_Blessed(belong: self.belong, texture: self.texture!, square: square)
                square.hasPiece = true
                square.piece = piece
                square.addChild(piece)
                generated = true
            }
            
            if i >= availableSquares.count {
                break
            }
            i+=1
        }
    }
    
    
    override func collectMove() {
        super.collectMove()
    }
    
    override func performMove(square: Square) {
        super.performMove(square: square)
        self.collectMove()
        for square in takableSquares {
            if (square.piece is King) {
                self.generateClone()
            }
        }
    }
}
