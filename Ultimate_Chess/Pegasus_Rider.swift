//
//  PegasusRider.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit

class Pegasus_Rider: Knight {
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "Pegasus_Rider"
        self.cost = PieceCosts[self.type]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*override func turnStartManner() {
        super.turnStartManner()
        self.canMove = GameManager.round % 2 == 0
    }*/
    
    override func collectMove() {
        self.takableSquares = []
        self.movableSquares = []
        PegasusRiderMove(piece: self, board: parent?.parent as! Board)
    }
}
