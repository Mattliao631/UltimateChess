//
//  Square.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/21.
//

import UIKit
import SpriteKit


class Square: SKSpriteNode {
    
    var boardCoordinate: ChessboardCoordinate = ChessboardCoordinate()
    var squareSize: CGSize = CGSize()
    var hasPiece: Bool = false
    var piece: ChessPiece?
    //到下面註解為止這幾個沒有實際用處
    init() {
        super.init(texture: SKTexture(imageNamed: "Test"),color: .white, size: squareSize)
        boardCoordinate = ChessboardCoordinate()
    }
    init(rank: Int) {
        super.init(texture: SKTexture(imageNamed: "Test"),color: .white, size: squareSize)
        boardCoordinate = ChessboardCoordinate(rank: rank)
    }
    init(file: Int) {
        super.init(texture: SKTexture(imageNamed: "Test"),color: .white, size: squareSize)
        boardCoordinate = ChessboardCoordinate(file: file)
    }
    //到上面註解為止這幾個沒有實際用處

    //要初始化都用下面這一個
    init(rank: Int, file: Int, size: CGSize) {
        let w = size.width / 10
        squareSize = CGSize(width: w, height: w)
        var imageName = ""
        if (rank+file) % 2 == 0 {
            imageName = "Square_Dark"
        } else {
            imageName = "Square_Light"
        }
        super.init(texture: SKTexture(imageNamed: imageName),color: .white, size: squareSize)
        
        boardCoordinate = ChessboardCoordinate(rank: rank, file: file)
        let vPosition = CGFloat((CGFloat(Float(self.boardCoordinate.rank) + 0.5)) * squareSize.height - 0.6 * size.width)
        let hPosition = CGFloat((CGFloat(Float(self.boardCoordinate.file) + 0.5)) * squareSize.width - size.width / 2)
        //print(hPosition, vPosition)
        self.zPosition = 1
        self.position = CGPoint(x: hPosition, y: vPosition)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
