//
//  Unicorn.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class Unicorn: Knight {
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "Unicorn"
        self.cost = PieceCosts[self.type]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectMove() {
        super.collectMove()
    }
    
    override func dieManner() {
        if GameManager.WaitingPiece == self {
            self.removePromptDots()
            GameManager.nextTurn()
            GameManager.WaitingPiece = nil
        }
    }
    
    override func take(square: Square) {
        super.take(square: square)
        GameManager.WaitingPiece = self
        self.removePromptDots()
        self.collectMove()
        self.takableSquares = []
        if self.movableSquares == [] {
            GameManager.WaitingPiece = nil
        }
        //print(self.movableSquares)
        self.pressentPromptDots()
    }
    override func performMove(square: Square) {
        if GameManager.WaitingPiece == self {
            GameManager.WaitingPiece = nil
        }
        self.removePromptDots()
        
        
        if self.movableSquares.contains(square) {
            self.move(square: square)
        } else if self.takableSquares.contains(square) {
            self.take(square: square)
        }
        
        if GameManager.WaitingPiece != self {
            GameManager.nextTurn()
        }
    }
}
