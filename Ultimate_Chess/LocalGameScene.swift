//
//  LocalGameScene.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/21.
//

import UIKit
import SpriteKit


class LocalGameScene: SKScene {
    var board: Board?
    
    override func didMove(to view: SKView) {
        print("Transition succeed!")
        board?.view = view
        board = Board()
        self.addChild(board!)
    }
}
