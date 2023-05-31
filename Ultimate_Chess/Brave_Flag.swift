//
//  BraveFlag.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class Brave_Flag: Rook {
    
    var BraveMoves = [Square]()
    
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "Brave_Flag"
        self.cost = PieceCosts[self.type]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pressentPromptDots() {
        super.pressentPromptDots()
        for square in BraveMoves {
            let dot = AvailableMovePromptDot(type: "Special", size: square.size)
            dot.name = "PromptDot"
            square.addChild(dot)
        }
    }
    
    override func removePromptDots() {
        super.removePromptDots()
        for square in BraveMoves {
            if let dot = (square.childNode(withName:"PromptDot") as? AvailableMovePromptDot) {
                dot.removeFromParent()
            }
        }
    }
    
    override func collectMove() {
        super.collectMove()
        self.BraveMoves = []
        BraveFlagMove(piece: self, board: GameManager.board!)
    }
    
    func braveTransposition(square: Square) {
        if let king = (square.piece as? King) {
            let flag = self
            
            let kingSquare = square
            let selfSquare = self.currentSquare!
            
            king.moved = true
            self.moved = true
            
            king.removeFromParent()
            self.removeFromParent()
            
            let vectorFK = kingSquare.position - selfSquare.position
            let vectorKF = -vectorFK
            
            kingSquare.piece = flag
            selfSquare.piece = king
            
            king.position = vectorFK
            self.position = vectorKF
            
            kingSquare.addChild(flag)
            selfSquare.addChild(king)
            
            king.currentSquare = selfSquare
            self.currentSquare = square
            
            let action = SKAction.move(to: CGPoint(x: 0,y: 0), duration: 0.1)
            king.run(action)
            flag.run(action)
            
            
        }
    }
    
    override func performMove(square: Square) {
        super.performMove(square: square)
        if self.BraveMoves.contains(square) {
            self.braveTransposition(square: square)
        }
    }
}
