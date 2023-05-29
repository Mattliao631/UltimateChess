//
//  UpgradeChoice.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class UpgradeChoice: SKSpriteNode {
    var type = ""
    init(texture: SKTexture, size: CGSize, type: String) {
        super.init(texture: texture, color: .white, size: size)
        self.type = type
    }
    func changePiece() {
        if let interface = (self.parent as? UpgradeInterface) {
            var imageName = ""
            let oldPiece = interface.selectedPiece!
            let square = oldPiece.currentSquare!
            let belong = oldPiece.belong
            
            
            if belong == 0 {
                imageName = "White_\(type)"
            } else if belong == 1 {
                imageName = "Black_\(type)"
            }
            
            
            let texture = SKTexture(imageNamed: imageName)
            var piece: ChessPiece!
            switch type {
            case "Pawn":
                piece = Pawn(belong: belong, texture: texture, square: square)
                break
            case "Zombie":
                piece = Zombie(belong: belong, texture: texture, square: square)
                break
            case "Rose_Garden_Guard":
                piece = Rose_Garden_Guard(belong: belong, texture: texture, square: square)
                break
            case "Knight":
                piece = Knight(belong: belong, texture: texture, square: square)
                break
            case "Pegasus_Rider":
                piece = Pegasus_Rider(belong: belong, texture: texture, square: square)
                break
            case "Unicorn":
                piece = Unicorn(belong: belong, texture: texture, square: square)
                break
            case "Bishop":
                piece = Bishop(belong: belong, texture: texture, square: square)
                break
            case "Divine_Blessed":
                piece = Divine_Blessed(belong: belong, texture: texture, square: square)
                break
            case "Space_Grimoire":
                piece = Space_Grimoire(belong: belong, texture: texture, square: square)
                break
            case "Rook":
                piece = Rook(belong: belong, texture: texture, square: square)
                break
            case "Brave_Flag":
                piece = Brave_Flag(belong: belong, texture: texture, square: square)
                break
            case "The_Indestructible":
                piece = The_Indestructible(belong: belong, texture: texture, square: square)
                break
            case "Queen":
                piece = Queen(belong: belong, texture: texture, square: square)
                break
            case "Rose_Queen":
                piece = Rose_Queen(belong: belong, texture: texture, square: square)
                break
            case "The_Fantasy":
                piece = The_Fantasy(belong: belong, texture: texture, square: square)
                break
            case "King":
                piece = King(belong: belong, texture: texture, square: square)
                break
            case "Conqueror":
                piece = Conqueror(belong: belong, texture: texture, square: square)
                break
            case "Underworld_Lord":
                piece = Underworld_Lord(belong: belong, texture: texture, square: square)
                break
            default:
                break
            }
            oldPiece.currentSquare = nil
            oldPiece.removeFromParent()
            square.piece = piece!
            square.addChild(piece)
            print(square.hasPiece)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
