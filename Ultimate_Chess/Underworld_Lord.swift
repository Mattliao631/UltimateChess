//
//  UnderworldLord.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/24.
//

import UIKit
import SpriteKit


class Underworld_Lord: King {
    var resurrectionMode = false
    var resurrectionCount = 5
    override init(belong: Int, texture: SKTexture, square: Square) {
        super.init(belong: belong, texture: texture, square: square)
//        self.resurrectionMode = false
//        self.resurrectionCount = 4
        self.type = "Underworld_Lord"
        self.cost = PieceCosts[self.type]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func turnStartManner() {
        //print(self.resurrectionCount, self.resurrectionMode)
        if self.resurrectionMode {
            resurrectionCount-=1
        }
        if self.resurrectionCount <= 0 {
            super.dieManner()
        }
    }
    
    override func dieManner() {
        self.resurrectionMode = true
        self.resurrectionCount -= 1
        if self.resurrectionCount <= 0 {
            super.dieManner()
            return
        }
        DispatchQueue.global().sync {
            GameManager.touchLock+=1
            self.dieEffect()
            
        }
    }
    
    override func dieEffect() {
        //------------------------------
        //  生成動畫
        //------------------------------
        //print(self.currentSquare?.boardCoordinate.rank, self.currentSquare?.boardCoordinate.file)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let takenPiece = self.currentSquare!.piece
            takenPiece?.removeFromParent()
            self.currentSquare!.hasPiece = true
            self.currentSquare!.piece = self
            self.currentSquare!.addChild(self)
            takenPiece?.dieManner()
            GameManager.touchLock-=1
        }
        

    }
    override func take(square: Square) {
        super.take(square: square)
        self.resurrectionCount += 1
    }
    
    override func collectMove() {
        super.collectMove()
    }
    override func performMove(square: Square) {
        super.performMove(square: square)
    }
}
