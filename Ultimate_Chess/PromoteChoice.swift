//
//  PromoteChoice.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/27.
//

import UIKit
import SpriteKit


class PromoteChoice: SKSpriteNode {
    var type = ""
    
    init(type: String, texture: SKTexture, size: CGSize) {
        super.init(texture: texture, color: .white, size: size)
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
