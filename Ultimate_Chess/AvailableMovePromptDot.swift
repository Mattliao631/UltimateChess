//
//  AvailableMovePromptDot.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/25.
//

import UIKit
import SpriteKit


class AvailableMovePromptDot: SKSpriteNode {
    
    var type = ""
    
    init(type: String, size: CGSize) {
        let texture = SKTexture(imageNamed: "Prompt_Dot_\(type)")
        super.init(texture: texture, color: .white, size: size)
        self.zPosition = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
