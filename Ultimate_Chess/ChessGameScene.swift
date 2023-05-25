//
//  ChessGameScene.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/25.
//

import UIKit
import SpriteKit


class ChessGameScene: SKScene {
    var board: Board!
    var turn = 0
    var round = 0
    override func didMove(to: SKView) {
        self.addChild(board)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
}
