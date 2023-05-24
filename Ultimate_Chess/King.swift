//
//  King.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/22.
//

import UIKit
import SpriteKit


class King: ChessPiece {
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "King"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectMove() {
        super.collectMove()
        KingMove(piece: self, board: parent?.parent as! Board)
        print(movableSquares, takableSquares)
    }
}
