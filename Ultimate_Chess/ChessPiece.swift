//
//  ChessPiece.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/21.
//

import UIKit
import SpriteKit



class ChessPiece: SKSpriteNode {
    
    var belong: Int = 0
    var currentSquare: Square?
    var movableSquares = [Square]()
    var takableSquares = [Square]()
    var takable: Bool = true
    var type: String = ""
    var cost: Int = 0
    var canMove = true
    var moved = false
    
    
    
    init() {
        super.init(texture: SKTexture(imageNamed: "Test"), color: .cyan, size: currentSquare?.size ?? CGSize())
        self.belong = 0
    }
    
    init(belong: Int, texture: SKTexture, square: Square) {
        super.init(texture: texture, color: .white, size: square.size)
        self.belong = belong
        self.currentSquare = square
        self.zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func turnStartManner() {
        self.turnStartEffect()
    }
    
    private func turnStartEffect() {}
    
    func dieManner() {
        self.DieEffect()
    }
    
    private func DieEffect() {}
    
    func collectMove() {
        movableSquares = []
        takableSquares = []
    }
    
    
    
    func move(square: Square) {
        let previousSquare = self.currentSquare!
        
        // remove self from original square
        let piece = self
        self.removeFromParent()
        previousSquare.hasPiece = false
        previousSquare.piece = nil
        
        // add self to new square
        piece.currentSquare = square
        square.hasPiece = true
        square.piece = piece
        
        // run the moving action
        let vector = square.position - previousSquare.position
        let action = SKAction.move(to: CGPoint(x: 0,y: 0), duration: 0.1)
        self.run(action)
        piece.position = -vector
        square.addChild(piece)
        
        //print(piece.position)
        self.moved = true
    }
    func take(square: Square) {
        let previousSquare = self.currentSquare!
        
        // remove self from original square
        let piece = self
        self.removeFromParent()
        previousSquare.hasPiece = false
        previousSquare.piece = nil
        
        // remove the piece being captured
        let takenPiece = square.piece!
        takenPiece.removeFromParent()
        square.hasPiece = false
        square.piece = nil
        
        // add self to new square
        piece.currentSquare = square
        square.hasPiece = true
        square.piece = piece
        
        // run the moving action
        let vector = square.position - previousSquare.position
        let action = SKAction.move(to: CGPoint(x: 0,y: 0), duration: 0.1)
        piece.run(action)
        piece.position = -vector
        square.addChild(piece)
        
        self.moved = true
        //print(piece.position)
        dieMannerPieces.append(takenPiece)
    }
    
    func pressentPromptDots() {
        for square in movableSquares {
            let dot = AvailableMovePromptDot(type: "Move", size: square.size)
            dot.name = "PromptDot"
            square.addChild(dot)
        }
        for square in takableSquares {
            let dot = AvailableMovePromptDot(type: "Take", size: square.size)
            dot.name = "PromptDot"
            square.addChild(dot)
        }
    }
    
    func removePromptDots() {
        for square in movableSquares {
            if let dot = (square.childNode(withName:"PromptDot") as? AvailableMovePromptDot) {
                dot.removeFromParent()
            }
        }
        for square in takableSquares {
            if let dot = (square.childNode(withName:"PromptDot") as? AvailableMovePromptDot) {
                dot.removeFromParent()
            }
        }
    }
    
    func performMove(square: Square) {
        if self.movableSquares.contains(square) {
            self.move(square: square)
        } else if self.takableSquares.contains(square) {
            self.take(square: square)
        }
    }
}
