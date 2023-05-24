//
//  Board.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/21.
//

import UIKit
import SpriteKit


class Board: SKSpriteNode {
    
    var squares = [[Square]]()
    
    init(texture: SKTexture, size: CGSize) {
        super.init(texture: texture, color: .white, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSquare(_ coordinate: ChessboardCoordinate) -> Square {
        return squares[coordinate.rank][coordinate.file]
    }
}
