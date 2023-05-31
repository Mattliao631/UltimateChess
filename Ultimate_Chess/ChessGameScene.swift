//
//  ChessGameScene.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/25.
//

import UIKit
import SpriteKit

//let EffectPerformTime:UInt64 = 1

class GameManager{
    static var touchLock: Int = 0
    static var WaitingPiece: ChessPiece?
    static var PromotingPiece: ChessPiece?
    static var selectedPiece: ChessPiece?
    static var winner: Int? = nil
    static var turn = 1
    static var round = 0
    static var board: Board!
    static func nextTurn() {
        //print("\(round), \(turn)")
        let queue = DispatchQueue.global(qos: .default)
        queue.async{
            while touchLock != 0 {
                Thread.sleep(forTimeInterval: 1)
            }
            turn = (turn + 1) % 2
            if turn == 0 {
                round += 1
                roundStart()
                turnStart()
            } else {
                turnStart()
            }
            selectedPiece = nil
        }
        
    }
    static func gameStart() {
        touchLock = 0
        WaitingPiece = nil
        PromotingPiece = nil
        selectedPiece = nil
        winner = nil
        turn = 1
        round = 0
        nextTurn()
    }
    
    static func roundStart() {
        
    }
    
    static func turnStart() {
        //print("turn0 start")
        for rank in boardLowerBound.rank...boardUpperBound.rank {
            for file in boardLowerBound.file...boardUpperBound.file {
                if let piece = (board.getSquare(ChessboardCoordinate(rank: rank, file: file)).piece) {
                    if piece.belong == turn {
                        piece.collectMove()
                        piece.turnStartManner()
                    }
                }
                //...other turn related pieces and so on
            }
        }
    }
}


class ChessGameScene: SKScene {
    
    
    @objc func detectWin() {
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
            GameManager.winner = nil
        }
    }
    
    override func didMove(to: SKView) {
        self.addChild(GameManager.board)
        GameManager.gameStart()
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(detectWin), userInfo: nil, repeats: true)
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print(GameManager.WaitingPiece)
        //print(GameManager.touchLock)
        if GameManager.touchLock == 0 {
            for touch in touches {
                let location = touch.location(in: self)
                let touchedNode = atPoint(location)
                let name = touchedNode.name!
                //print(touchedNode.name)
                if GameManager.PromotingPiece != nil {
                    if let choice = (touchedNode as? PromoteChoice) {
                        choice.performPromotion()
                    }
                    return
                }
                if GameManager.WaitingPiece != nil {
                    if name == "PromptDot" {
                        let square = touchedNode.parent as! Square
                        //Move, capture, or special move
                        GameManager.WaitingPiece!.performMove(square: square)
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
                //self.detectWin()
            }
        }
    }
}
