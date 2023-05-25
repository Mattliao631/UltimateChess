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
    var selectedPiece: ChessPiece?
    
    
    override func didMove(to: SKView) {
        self.addChild(board)
    }
    
    func pressentPromptDots() {
        let movableSquares = selectedPiece!.movableSquares
        let takableSquares = selectedPiece!.takableSquares
        for square in movableSquares {
            let dot = AvailableMovePromptDot(type: "Move", size: square.size)
            dot.name = "PromptDot"
            square.addChild(dot)
        }
        for square in takableSquares {
            let dot = AvailableMovePromptDot(type: "Take", size: square.size)
            dot.name = "PromptDot"
            square.addChild(dot)
        }
    }
    
    func removePromptDots() {
        let movableSquares = selectedPiece!.movableSquares
        let takableSquares = selectedPiece!.takableSquares
        for square in movableSquares {
            if let dot = (square.childNode(withName:"PromptDot") as? AvailableMovePromptDot) {
                dot.removeFromParent()
            }
        }
        for square in takableSquares {
            if let dot = (square.childNode(withName:"PromptDot") as? AvailableMovePromptDot) {
                dot.removeFromParent()
            }
        }
    }
    
    func nextTurn() {
        turn = (turn + 1) % 2
        if turn == 0 {
            round += 1
        }
        selectedPiece = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            let name = touchedNode.name!
            print(name)
            switch name {
            case "ChessPiece":
                if selectedPiece != nil {
                    removePromptDots()
                }
                selectedPiece = (touchedNode as! ChessPiece)
                if selectedPiece!.belong == turn {
                    selectedPiece!.collectMove()
                    pressentPromptDots()
                } else {
                    selectedPiece = nil
                }
                break
            case "PromptDot":
                let square = touchedNode.parent as! Square
                removePromptDots()
                //Move, capture, or special move
                if selectedPiece!.movableSquares.contains(square) {
                    selectedPiece!.move(square: square)
                } else if selectedPiece!.takableSquares.contains(square) {
                    selectedPiece!.take(square: square)
                }
                
                
                nextTurn()
                break
            default:
                if name.first! == "(" {
                    if selectedPiece != nil {
                        removePromptDots()
                    }
                }
                break
            }
        }
    }
}
