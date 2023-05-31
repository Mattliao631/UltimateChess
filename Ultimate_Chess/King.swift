//
//  King.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/22.
//

import UIKit
import SpriteKit


class King: ChessPiece {
    
    var castleSquares = [Square]()
    
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "King"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func dieManner() {
        super.dieManner()
        if self.belong == 0 {
            GameManager.winner = 1
        } else if self.belong == 1 {
            GameManager.winner = 0
        }
    }
    
    override func collectMove() {
        super.collectMove()
        self.castleSquares = []
        KingMove(piece: self, board: parent?.parent as! Board)
    }
    
    func castle(square: Square) {
        let board = (self.parent?.parent as! Board)
        
        let previousSquare1 = self.currentSquare!
        var previousSquare2: Square!
        
        var newRookSquare: Square!
        
        if square.boardCoordinate <= self.currentSquare!.boardCoordinate {
            previousSquare2 = board.getSquare(ChessboardCoordinate(rank: self.currentSquare!.boardCoordinate.rank, file: boardLowerBound.file))
            newRookSquare = board.getSquare(self.currentSquare!.boardCoordinate - ChessboardCoordinate(file: 1))
        } else {
            previousSquare2 = board.getSquare(ChessboardCoordinate(rank: self.currentSquare!.boardCoordinate.rank, file: boardUpperBound.file))
            newRookSquare = board.getSquare(self.currentSquare!.boardCoordinate + ChessboardCoordinate(file: 1))
        }
        
        //remove pieces going to be moved from original sqaures
        let piece1 = self
        let piece2 = previousSquare2.piece!
        self.removeFromParent()
        piece2.removeFromParent()
        previousSquare1.hasPiece = false
        previousSquare2.hasPiece = false
        previousSquare1.piece = nil
        previousSquare2.piece = nil
        
        // add pieces to new squares
        piece1.currentSquare = square
        square.hasPiece = true
        square.piece = piece1
        
        piece2.currentSquare = newRookSquare
        newRookSquare.hasPiece = true
        newRookSquare.piece = piece2
        
        //run moving actions
        let vector1 = square.position - previousSquare1.position
        let vector2 = newRookSquare.position - previousSquare2.position
        let action = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.1)
        piece1.run(action)
        piece2.run(action)
        piece1.position = -vector1
        piece2.position = -vector2
        square.addChild(piece1)
        newRookSquare.addChild(piece2)
        
        piece1.moved = true
        piece2.moved = true
    }
    
    override func pressentPromptDots() {
        super.pressentPromptDots()
        for square in self.castleSquares {
            let dot = AvailableMovePromptDot(type: "Castle", size: square.size)
            dot.name = "PromptDot"
            square.addChild(dot)
        }
    }
    
    override func removePromptDots() {
        super.removePromptDots()
        for square in castleSquares {
            if let dot = (square.childNode(withName: "PromptDot") as? AvailableMovePromptDot) {
                dot.removeFromParent()
            }
        }
    }
    
    override func performMove(square: Square) {
        if self.castleSquares.contains(square) {
            self.castle(square: square)
        }
        super.performMove(square: square)
    }
    
    
}
