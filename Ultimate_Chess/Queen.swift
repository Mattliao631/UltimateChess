//
//  Queen.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/22.
//

import UIKit
import SpriteKit

class Queen: ChessPiece {
    override init(belong: Int, name: String, square: Square) {
        super.init(belong: belong, name: name, square: square)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectMove() {
        super.collectMove()
        QueenMove(piece: self, board: parent?.parent as! Board)
        print(movableSquares, takableSquares)
    }
}
