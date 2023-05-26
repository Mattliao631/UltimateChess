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
    var round = 1
    var selectedPiece: ChessPiece?
    var TakenPiece: ChessPiece?
    
    func gameStart() {
        
    }
    
    func roundStart() {
        
    }
    
    func turn0Start() {
        
    }
    
    func turn1Start() {
        
    }
    
    override func didMove(to: SKView) {
        self.addChild(board)
    }
    
    
    func nextTurn() {
        turn = (turn + 1) % 2
        if turn == 0 {
            round += 1
            roundStart()
            turn0Start()
        } else {
            turn1Start()
        }
        selectedPiece = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            let name = touchedNode.name!
            
            switch name {
            case "ChessPiece":
                if selectedPiece != nil {
                    selectedPiece!.removePromptDots()
                }
                selectedPiece = (touchedNode as! ChessPiece)
                if selectedPiece!.belong == turn {
                    selectedPiece!.collectMove()
                    selectedPiece!.pressentPromptDots()
                } else {
                    selectedPiece = nil
                }
                break
            case "PromptDot":
                let square = touchedNode.parent as! Square
                //Move, capture, or special move
                selectedPiece!.performMove(square: square)
                
                selectedPiece!.removePromptDots()
                
                nextTurn()
                break
            default:
                if name.first! == "(" {
                    if selectedPiece != nil {
                        selectedPiece!.removePromptDots()
                    }
                }
                break
            }
        }
    }
}
