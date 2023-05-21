//
//  ChessPiece.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/21.
//

import UIKit
import SpriteKit


class ChessPiece: SKSpriteNode {
    
    var belong: Int = 0
    var currentSquare: Square?
    var movableSquares: [Square]?
    var takableSquares: [Square]?
    
    init() {
        super.init(texture: SKTexture(imageNamed: "Test"), color: .cyan, size: currentSquare?.squareSize ?? CGSize())
        self.belong = 0
    }
    
    init(belong: Int, name: String) {
        super.init(texture: SKTexture(imageNamed: name), color: .white, size: currentSquare?.size ?? CGSize())
        self.belong = belong
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectMove() {
        movableSquares = []
        takableSquares = []
    }
    
}
