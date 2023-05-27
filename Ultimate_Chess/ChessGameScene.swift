//
//  ChessGameScene.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/25.
//

import UIKit
import SpriteKit


var dieMannerPieces = [ChessPiece]()
var turnStartMannerPieces = [[ChessPiece]]()
var PromotingPiece: ChessPiece?

class ChessGameScene: SKScene {
    var board: Board!
    var turn = 1
    var round = 0
    var selectedPiece: ChessPiece?
    var TakenPiece: ChessPiece?
    
    
    func performDieEffect() {
        while !dieMannerPieces.isEmpty {
            let piece = dieMannerPieces[0]
            piece.dieManner()
        }
    }
    
    func gameStart() {
        let temp0 = [ChessPiece]()
        let temp1 = [ChessPiece]()
        turnStartMannerPieces.append(temp0)
        turnStartMannerPieces.append(temp1)
        nextTurn()
    }
    
    func roundStart() {
        
    }
    
    func turn0Start() {
        //print("turn0 start")
        for piece in turnStartMannerPieces[0] {
            piece.turnStartManner()
        }
    }
    
    func turn1Start() {
        //print("turn1 start")
        for piece in turnStartMannerPieces[1] {
            piece.turnStartManner()
        }
    }
    
    override func didMove(to: SKView) {
        self.addChild(board)
        gameStart()
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
            
            if PromotingPiece != nil {
                if let choice = (touchedNode as? PromoteChoice) {
                    let square = (PromotingPiece?.currentSquare!)!
                    var piece:ChessPiece?
                    let texture = choice.texture!
                    switch choice.type {
                    case "Queen":
                        piece = Queen(belong: PromotingPiece!.belong, texture: texture, square: square)
                        break
                    case "Rook":
                        piece = Rook(belong: PromotingPiece!.belong, texture: texture, square: square)
                        break
                    case "Knight":
                        piece = Knight(belong: PromotingPiece!.belong, texture: texture, square: square)
                        break
                    case "Bishop":
                        piece = Bishop(belong: PromotingPiece!.belong, texture: texture, square: square)
                        break
                    default:
                        break
                    }
                    piece?.name = "ChessPiece"
                    square.piece=piece
                    square.addChild(piece!)
                    PromotingPiece?.removeFromParent()
                    PromotingPiece = nil
                }
                return
            }
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
