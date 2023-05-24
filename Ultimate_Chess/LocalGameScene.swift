//
//  LocalGameScene.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/21.
//

import UIKit
import SpriteKit


class LocalGameScene: SKScene {
    
    
    
    var board: Board!
    let numberOfPlayers = 2
    var upGradePointDisplay = [SKSpriteNode]()
    var upGradePoint = [Int]()
    
    func createBoard() {
        let texture = SKTexture(imageNamed: "ChessBoard")
        board = Board(texture: texture, size: self.size)
        board.name = "ChessBoard"
        board.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        board.zPosition = -1
        self.addChild(board)
        createSquares()
    }
    
    func createSquares() {
        for rank in 0...11 {
            var tempRank = [Square]()
            for file in 0...9 {
                var imageName = ""
                if (rank+file) % 2 == 0 {
                    imageName = "Square_Dark"
                } else {
                    imageName = "Square_Light"
                }
                
                let texture = SKTexture(imageNamed: imageName)
                let square = Square(texture: texture, size: self.size, rank: rank, file: file)
                square.name = "(\(rank),\(file))"
                var piece = ChessPiece()
                if let imageName = UltimateChessMapping[square.name!] {
                    let texture = SKTexture(imageNamed: imageName)
                    switch imageName {
                    case "White_Pawn":
                        piece = Pawn(belong: 0, texture: texture, square: square)
                        piece.type = "Pawn"
                        break
                    case "White_Knight":
                        piece = Knight(belong: 0, texture: texture, square: square)
                        piece.type = "Knight"
                        break
                    case "White_Bishop":
                        piece = Bishop(belong: 0, texture: texture, square: square)
                        piece.type = "Bishop"
                        break
                    case "White_Rook":
                        piece = Rook(belong: 0, texture: texture, square: square)
                        piece.type = "Rook"
                        break
                    case "White_Queen":
                        piece = Queen(belong: 0, texture: texture, square: square)
                        piece.type = "Queen"
                        break
                    case "White_King":
                        piece = King(belong: 0, texture: texture, square: square)
                        piece.type = "King"
                        break
                    case "Black_Pawn":
                        piece = Pawn(belong: 1, texture: texture, square: square)
                        piece.type = "Pawn"
                        break
                    case "Black_Knight":
                        piece = Knight(belong: 1, texture: texture, square: square)
                        piece.type = "Knight"
                        break
                    case "Black_Bishop":
                        piece = Bishop(belong: 1, texture: texture, square: square)
                        piece.type = "Bishop"
                        break
                    case "Black_Rook":
                        piece = Rook(belong: 1, texture: texture, square: square)
                        piece.type = "Rook"
                        break
                    case "Black_Queen":
                        piece = Queen(belong: 1, texture: texture, square: square)
                        piece.type = "Queen"
                        break
                    case "Black_King":
                        piece = King(belong: 1, texture: texture, square: square)
                        piece.type = "King"
                        break
                    default:
                        break
                    }
                    piece.name = "ChessPiece"
                    piece.zPosition = 1
                    if piece.belong == 1 {
                        piece.zRotation = MLPi
                    }
                    square.addChild(piece)
                }
                tempRank.append(square)
                board.addChild(square)
            }
            board.squares.append(tempRank)
        }
    }
    
    
    
    func createButtons() {
        //print(1)
        createBackButton()
        //print(2)
        createConfirmButton()
        //print(3)
        createUpGradePoint()
    }
    
    func createBackButton() {
        let texture = SKTexture(imageNamed: "Back_Button")
        let backButton = SKSpriteNode(texture: texture, size: CGSize(width: size.width * 0.1, height: size.height * 0.05))
        backButton.zPosition = 1
        backButton.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.9)
        backButton.name = "BackButton"
        self.addChild(backButton)
    }
    
    func createConfirmButton() {
        for i in 0...(numberOfPlayers - 1) {
            let size = CGSize(width: self.frame.midX, height: self.frame.height * 0.07)
            let confirm = SKSpriteNode(color: .white, size: size)
            confirm.zPosition = 1
            confirm.position = CGPoint(x: self.frame.midX, y: self.frame.maxY * abs(CGFloat(i) - 0.07))
            confirm.name = "Player\(i)'s Confirm"
            self.addChild(confirm)
        }
    }
    
    func createUpGradeInterface(belong: Int, typeList: [String]) {

        let texture = SKTexture(imageNamed: "Upgrade_Interface")
        let size = CGSize(width: self.frame.width, height: self.frame.height * 0.3)
        let interface = SKSpriteNode(texture: texture, color: .white, size: size)
        interface.name = "Player\(belong)'s Interface"
        interface.position = CGPoint(x: self.frame.midX, y: self.frame.maxY * abs(CGFloat(belong) - 0.25))
        interface.zPosition = 2
        
        createExitButton(belong: belong, interface: interface)
        createUpGradeChoice(belong: belong, typeList: typeList)
        
        interface.zRotation = CGFloat(belong) * MLPi
        self.addChild(interface)
    }
    
    func createExitButton(belong: Int, interface: SKSpriteNode) {
        let texture = SKTexture(imageNamed: "Interface_Exit")
        let w = interface.size.width / 10
        let size = CGSize(width: w, height: w)
        let exit = SKSpriteNode(texture: texture, color: .white, size: size)
        exit.zPosition = 1
        exit.name = "Player\(belong)'s Interface Exit"
        exit.position = CGPoint(x: 4 * w,y: interface.size.height * 0.35)
        interface.addChild(exit)
    }
    
    func createUpGradeChoice (belong: Int, typeList: [String]) {
        print(belong, typeList)
    }
    
    func createUpGradePoint() {
        for i in 0...(numberOfPlayers-1) {
            upGradePoint.append(80)
            let point = SKSpriteNode(color: .cyan, size: CGSize(width: self.frame.width / 7, height: self.frame.height * 0.05))
            let label = SKLabelNode(text: "\(upGradePoint[i])")
            label.horizontalAlignmentMode = .center
            label.verticalAlignmentMode = .center
            label.fontSize = 30
            label.fontName = "Avenir"
            label.fontColor = .black
            label.zPosition = 1
            label.name = "Player\(i)'s Point"
            point.addChild(label)
            point.zPosition = 1
            point.position = CGPoint(x: self.size.width * 0.9, y: self.frame.maxY * abs(CGFloat(i) - 0.05))
            point.name = "Player\(i)'s Point Background"
            upGradePointDisplay.append(point)
            self.addChild(point)
        }
    }
    
    
    override func didMove(to view: SKView) {
        print("Transition succeed!")
        createButtons()
        createBoard()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if let touchedPiece = touchedNode as? ChessPiece {
                var touchedType = [String]()
                for tuple in ChessTypes {
                    for type in tuple.value {
                        if touchedPiece.type == type {
                            touchedType = tuple.value
                            break
                        }
                        if touchedType != [] {
                            break
                        }
                    }
                }
                createUpGradeInterface(belong: touchedPiece.belong, typeList: touchedType)
            } else if touchedNode.name == "BackButton" {
                //print("BackButton!")
                let MainMenuScene = MainMenuScene(size: self.size)
                MainMenuScene.scaleMode = self.scaleMode
                let trans = SKTransition.flipVertical(withDuration: 1)
                self.view?.presentScene(MainMenuScene, transition: trans)
                self.removeFromParent()
            } else if touchedNode.name == "Player0's Interface Exit" {
                if let interface = self.childNode(withName: "Player0's Interface"){
                    interface.removeFromParent()
                }
            } else if touchedNode.name == "Player1's Interface Exit" {
                if let interface = self.childNode(withName: "Player1's Interface"){
                    interface.removeFromParent()
                }
            } else if touchedNode.name == "Player0's Confirm" {
                
            } else if touchedNode.name == "Player1's Confirm" {
                
            }
        }
    }
}
