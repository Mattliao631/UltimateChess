//
//  LocalGameScene.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/21.
//

import UIKit
import SpriteKit


class LocalGameScene: SKScene {
    
    let backButton = SKSpriteNode(texture: SKTexture(imageNamed: "Back_Button"))
    
    override func didMove(to view: SKView) {
        print("Transition succeed!")
        backButton.size = CGSize(width: self.size.width / 10, height: self.size.height / 20)
        backButton.position = CGPoint(x: self.size.width / 10, y: self.size.height * 0.9)
        backButton.name = "BackButton"
        self.addChild(backButton)
        
        let board = Board(size: self.size)
        board.zPosition = -1
        board.name = "Board"
        self.addChild(board)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self.view)
            let touchedNode = atPoint(location)
            
            if let nodeName = touchedNode.name {
                switch nodeName {
                case "ChessPiece":
                    if let touchedPiece = touchedNode as? ChessPiece {
                        print(touchedPiece.type)
                    }
                    break
                case "BackButton":
                    
                    break
                default:
                    break
                }
            }
        }
    }
}
