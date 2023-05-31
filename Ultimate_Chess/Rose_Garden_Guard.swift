//
//  RoseGardenGuard.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class Rose_Garden_Guard: Pawn {
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
        self.type = "Rose_Garden_Guard"
        self.cost = PieceCosts[self.type]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectMove() {
        super.collectMove()
    }
    override func Promote() {
        let promoteList = ["Rose_Queen", "Rook", "Knight", "Bishop"]
        var color = ""
        if self.belong == 0 {
            color = "White"
        } else if self.belong == 1 {
            color = "Black"
        }
        
        for i in 0...3 {
            let texture = SKTexture(imageNamed: "\(color)_\(promoteList[i])")
            let choice = PromoteChoice(type: promoteList[i], texture: texture, size: self.size)
            let backGround = SKSpriteNode(color: .white, size: self.size)
            backGround.zPosition = -1
            choice.zPosition = 2
            choice.position = CGPoint(x: 0, y: CGFloat(i * (2 * belong - 1)) * self.size.height)
            choice.size = self.size
            choice.addChild(backGround)
            choice.name = "Promote Choice"
            self.addChild(choice)
            GameManager.PromotingPiece = self
        }
    }
}
