//
//  ChessGameScene.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/25.
//

import UIKit
import SpriteKit

class GameManager{
    static var dieMannerPieces = [ChessPiece]()
    static var pieces = [[ChessPiece]]()
    static var PromotingPiece: ChessPiece?
    static var selectedPiece: ChessPiece?
    static var winner: Int? = nil
    static var turn = 1
    static var round = 0
    static var board: Board!
    static func nextTurn() {
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
    static func gameStart() {
        dieMannerPieces=[ChessPiece]()
        PromotingPiece=nil
        selectedPiece=nil
        winner=nil
        turn=1
        round=0
        pieces=[[ChessPiece]]()
        let temp0 = [ChessPiece]()
        let temp1 = [ChessPiece]()
        pieces.append(temp0)
        pieces.append(temp1)
        for rank in boardLowerBound.rank...boardUpperBound.rank {
            for file in boardLowerBound.file...boardUpperBound.file {
                if let piece = (board.getSquare(ChessboardCoordinate(rank: rank, file: file)).piece) {
                    pieces[piece.belong].append(piece)
                }
                //...other turn related pieces and so on
            }
        }
        nextTurn()
    }
    
    static func roundStart() {
        
    }
    
    static func turn0Start() {
        //print("turn0 start")
        for piece in pieces[0] {
            piece.turnStartManner()
        }
    }
    
    static func turn1Start() {
        //print("turn1 start")
        for piece in pieces[1] {
            piece.turnStartManner()
        }
    }
    
    static func performDieEffect() {
        while !dieMannerPieces.isEmpty {
            let piece = dieMannerPieces[0]
            piece.dieManner()
            dieMannerPieces.remove(at:0)
        }
    }
}


class ChessGameScene: SKScene {
    
    
    func performWin() {
        if let winner = GameManager.winner {
            var color = ""
            if winner == 0 {
                color="White"
            } else if winner == 1 {
                color="Black"
            }
            let alert = UIAlertController(title: "Winner is \(color)!", message: "Congratulations", preferredStyle: .alert)
            let action = UIAlertAction(title: "Yeah!", style: .default, handler: {_ in
                let scene = MainMenuScene(size: self.size)
                scene.scaleMode = self.scaleMode
                let trans = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(scene, transition: trans)
                GameManager.board = nil
                self.removeFromParent()
            })
            alert.addAction(action)
            self.view?.window?.rootViewController?.present(alert, animated: true)
        }
    }
    
    override func didMove(to: SKView) {
        self.addChild(GameManager.board)
        GameManager.gameStart()
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            let name = touchedNode.name!
            //print(touchedNode.name)
            if GameManager.PromotingPiece != nil {
                if let choice = (touchedNode as? PromoteChoice) {
                    let square = (GameManager.PromotingPiece?.currentSquare!)!
                    var piece:ChessPiece?
                    let texture = choice.texture!
                    switch choice.type {
                    case "Queen":
                        piece = Queen(belong: GameManager.PromotingPiece!.belong, texture: texture, square: square)
                        break
                    case "Rook":
                        piece = Rook(belong: GameManager.PromotingPiece!.belong, texture: texture, square: square)
                        break
                    case "Knight":
                        piece = Knight(belong: GameManager.PromotingPiece!.belong, texture: texture, square: square)
                        break
                    case "Bishop":
                        piece = Bishop(belong: GameManager.PromotingPiece!.belong, texture: texture, square: square)
                        break
                    default:
                        break
                    }
                    square.piece=piece
                    square.addChild(piece!)
                    GameManager.PromotingPiece?.removeFromParent()
                    GameManager.PromotingPiece = nil
                }
                return
            }
            switch name {
            case "ChessPiece":
                if GameManager.selectedPiece != nil {
                    GameManager.selectedPiece!.removePromptDots()
                }
                GameManager.selectedPiece = (touchedNode as! ChessPiece)
                if GameManager.selectedPiece!.belong == GameManager.turn && GameManager.selectedPiece!.canMove {
                    GameManager.selectedPiece!.collectMove()
                    GameManager.selectedPiece!.pressentPromptDots()
                } else {
                    GameManager.selectedPiece = nil
                }
                break
            case "PromptDot":
                let square = touchedNode.parent as! Square
                //Move, capture, or special move
                GameManager.selectedPiece!.performMove(square: square)
                break
            default:
                if name.first! == "(" {
                    if GameManager.selectedPiece != nil {
                        GameManager.selectedPiece!.removePromptDots()
                    }
                }
                break
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                GameManager.performDieEffect()
                self.performWin()
            }
        }
    }
}
