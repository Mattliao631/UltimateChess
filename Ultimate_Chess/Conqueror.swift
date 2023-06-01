//
//  Conqueror.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class Conqueror: King {
    
    var conqueredType = ""
    
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "Conqueror"
        self.cost = PieceCosts[self.type]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectMove() {
        super.collectMove()
        switch conqueredType {
        case "Pawn":
            PawnMove(piece: self, board: GameManager.board!)
            break
        case "Rook":
            RookMove(piece: self, board: GameManager.board!)
            break
        case "Knight":
            KnightMove(piece: self, board: GameManager.board!)
            break
        case "PegasusRider":
            PegasusRiderMove(piece: self, board: GameManager.board!)
            break
        case "Bishop":
            BishopMove(piece: self, board: GameManager.board!)
            break
        case "SpaceGrimoire":
            SpaceGrimoireMove(piece: self, board: GameManager.board!)
            break
        case "Queen":
            QueenMove(piece: self, board: GameManager.board!)
            break
        default:
            break
        }
    }
    
    override func take(square: Square) {
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
        takenPiece.dieManner()
        
        if (takenPiece is Space_Grimoire) {
            self.conqueredType = "SpaceGrimoire"
        } else if (takenPiece is Pegasus_Rider) {
            self.conqueredType = "PegasusRider"
        }  else if (takenPiece is Pawn) {
            self.conqueredType = "Pawn"
        } else if (takenPiece is Queen) {
            self.conqueredType = "Queen"
        } else if (takenPiece is Rook) {
            self.conqueredType = "Rook"
        }else if (takenPiece is Knight) {
            self.conqueredType = "Knight"
        } else if (takenPiece is Bishop) {
            self.conqueredType = "Bishop"
        } else if (takenPiece is King) {
            self.conqueredType = "King"
        }
        
        
        GameManager.WaitingPiece = self
        
        self.removePromptDots()
        self.collectMove()
        if self.movableSquares == [] && self.takableSquares == [] {
            GameManager.WaitingPiece = nil
        }
        
        self.pressentPromptDots()
    }
    
    
    override func performMove(square: Square) {
        if GameManager.WaitingPiece == self {
            GameManager.WaitingPiece = nil
        }
        self.removePromptDots()
        
        if self.castleSquares.contains(square) {
            self.castle(square: square)
        }
        
        if self.movableSquares.contains(square) {
            self.move(square: square)
        } else if self.takableSquares.contains(square) {
            self.take(square: square)
        }
        
        if let effect = self.currentSquare?.childNode(withName: "FantasyEffect") as? FantasyEffect {
            if effect.belong == self.belong {
                self.isFantastic = true
                effect.removeFromParent()
            }
        }
        
        if GameManager.WaitingPiece != self {
            self.conqueredType = ""
            GameManager.nextTurn()
        }
    }
}
