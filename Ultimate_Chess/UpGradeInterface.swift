//
//  UpGradeInterface.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class UpgradeInterface: SKSpriteNode {
    var selectedPiece:ChessPiece!
    
    init(texture: SKTexture, size: CGSize, piece: ChessPiece) {
        super.init(texture: texture, color: .white, size: size)
        selectedPiece = piece
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
