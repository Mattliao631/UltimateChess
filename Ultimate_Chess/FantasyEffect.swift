//
//  FantasyEffect.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/6/1.
//

import UIKit
import SpriteKit


class FantasyEffect: SKSpriteNode {
    var belong: Int = 0
    init(belong: Int, texture: SKTexture?, size: CGSize) {
        super.init(texture: texture, color: .white, size: size)
        self.belong = belong
        self.zPosition = 1
        self.zRotation = Double(self.belong) * MLPi
        self.name = "FantasyEffect"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
