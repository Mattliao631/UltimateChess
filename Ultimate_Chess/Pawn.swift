//
//  Pawn.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/22.
//

import UIKit
import SpriteKit


class Pawn: ChessPiece {
    
    var canBeEnPassant: Bool = false
    var EnPassantSquares = [Square]()
    
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "Pawn"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func turnStartManner() {
        super.turnStartManner()
        self.canBeEnPassant = false
        //print(GameManager.turnStartMannerPieces)
    }
    
    
    override func collectMove() {
        super.collectMove()
        EnPassantSquares = []
        PawnMove(piece: self, board: parent?.parent as! Board)
    }
    
    override func move(square: Square) {
        let previousSquare = self.currentSquare!
        let vector = square.position - previousSquare.position
        let action = SKAction.move(to: CGPoint(x: 0,y: 0), duration: 0.1)
        self.run(action)
        let piece = self
        self.removeFromParent()
        previousSquare.hasPiece = false
        previousSquare.piece = nil
        piece.currentSquare = square
        square.hasPiece = true
        square.piece = piece
        piece.position = -vector
        square.addChild(piece)
        //  print(piece.position)
        if abs(square.boardCoordinate.rank - previousSquare.boardCoordinate.rank) > 1 {
            self.canBeEnPassant = true
        }
    }
    
    func EnPassant(square: Square) {
        let board = GameManager.board!
        super.move(square: square)
        var direction: ChessboardCoordinate!
        if self.belong == 0 {
            direction = ChessboardCoordinate(rank: 1)
        } else if self.belong == 1 {
            direction = ChessboardCoordinate(rank: -1)
        }
        let EnPassantOnSquare = board.getSquare(square.boardCoordinate - direction)
        let EnPassant = EnPassantOnSquare.piece!
        EnPassant.removeFromParent()
        EnPassantOnSquare.hasPiece = false
        EnPassantOnSquare.piece = nil
    }
    
    func Promote() {
        let promoteList = ["Queen", "Rook", "Knight", "Bishop"]
        var color = ""
        if self.belong == 0 {
            color = "White"
        } else if self.belong == 1 {
            color = "Black"
        }
        
        for i in 0...3 {
            let texture = SKTexture(imageNamed: "\(color)_\(promoteList[i])")
            let choice = PromoteChoice(type: promoteList[i], texture: texture, size: self.size)
            let backGround = SKSpriteNode(color: .white, size: self.size)
            backGround.zPosition = -1
            choice.position = CGPoint(x: 0, y: CGFloat(i * (2 * belong - 1)) * self.size.height)
            choice.size = self.size
            choice.addChild(backGround)
            choice.name = "Promote Choice"
            self.addChild(choice)
            GameManager.PromotingPiece = self
        }
    }
    
    override func pressentPromptDots() {
        super.pressentPromptDots()
        for square in EnPassantSquares {
            let dot = AvailableMovePromptDot(type: "Special", size: square.size)
            dot.name = "PromptDot"
            square.addChild(dot)
        }
    }
    
    override func removePromptDots() {
        super.removePromptDots()
        for square in EnPassantSquares {
            if let dot = (square.childNode(withName: "PromptDot") as? AvailableMovePromptDot) {
                dot.removeFromParent()
            }
        }
    }
    
    override func performMove(square: Square) {
        super.performMove(square: square)
        if self.EnPassantSquares.contains(square) {
            self.EnPassant(square: square)
        }
        var promoteRank = 0
        if self.belong == 0 {
            promoteRank = 9
        } else if self.belong == 1 {
            promoteRank = 0
        }
        if self.currentSquare?.boardCoordinate.rank == promoteRank {
            self.Promote()
        }
    }
}
