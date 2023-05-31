//
//  PromoteChoice.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/27.
//

import UIKit
import SpriteKit


class PromoteChoice: SKSpriteNode {
    var type = ""
    
    init(type: String, texture: SKTexture, size: CGSize) {
        super.init(texture: texture, color: .white, size: size)
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performPromotion() {
        let square = (GameManager.PromotingPiece?.currentSquare!)!
        var piece:ChessPiece?
        let texture = self.texture!
        switch self.type {
        case "Rose_Queen":
            piece = Rose_Queen(belong: GameManager.PromotingPiece!.belong, texture: texture, square: square)
        case "Queen":
            piece = Queen(belong: GameManager.PromotingPiece!.belong, texture: texture, square: square)
            break
        case "Rook":
            piece = Rook(belong: GameManager.PromotingPiece!.belong, texture: texture, square: square)
            break
        case "Knight":
            piece = Knight(belong: GameManager.PromotingPiece!.belong, texture: texture, square: square)
            break
        case "Bishop":
            piece = Bishop(belong: GameManager.PromotingPiece!.belong, texture: texture, square: square)
            break
        default:
            break
        }
        square.piece=piece
        square.addChild(piece!)
        GameManager.PromotingPiece?.removeFromParent()
        GameManager.PromotingPiece = nil
    }
}
