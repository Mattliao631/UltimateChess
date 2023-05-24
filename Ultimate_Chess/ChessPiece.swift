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
    var movableSquares = [Square]()
    var takableSquares = [Square]()
    var takable: Bool = true
    var type: String = ""
    
    init() {
        super.init(texture: SKTexture(imageNamed: "Test"), color: .cyan, size: currentSquare?.squareSize ?? CGSize())
        self.belong = 0
    }
    
    init(belong: Int, texture: SKTexture, square: Square) {
        super.init(texture: texture, color: .white, size: square.size)
        self.belong = belong
        self.currentSquare = square
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectMove() {
        movableSquares = []
        takableSquares = []
    }
    
}
