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
    var confirm_0 = false
    var confirm_1 = false
    
    override func didMove(to view: SKView) {
        print("Transition succeed!")
        createButtons()
        createBoard()
    }
    
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
        createBackButton()
        createConfirmButton()
        createUpgradePoint()
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
    
    func createUpgradeInterface(piece: ChessPiece, typeList: [String]) {

        let texture = SKTexture(imageNamed: "Upgrade_Interface")
        let size = CGSize(width: self.frame.width, height: self.frame.height * 0.2)
        let interface = UpgradeInterface(texture: texture, size: size, piece: piece)
        interface.name = "Player\(piece.belong)'s Interface"
        interface.position = CGPoint(x: self.frame.midX, y: self.frame.maxY * abs(CGFloat(piece.belong) - 0.25))
        interface.zPosition = 2
        
        createExitButton(interface: interface)
        createUpgradeChoice(typeList: typeList, interface: interface)
        
        interface.zRotation = CGFloat(piece.belong) * MLPi
        self.addChild(interface)
    }
    
    func createExitButton(interface: UpgradeInterface) {
        let texture = SKTexture(imageNamed: "Interface_Exit")
        let w = interface.size.width / 10
        let size = CGSize(width: w, height: w)
        let exit = SKSpriteNode(texture: texture, color: .white, size: size)
        exit.zPosition = 3
        exit.name = "Player\(interface.selectedPiece.belong)'s Interface Exit"
        exit.position = CGPoint(x: 4 * w,y: interface.size.height * 0.35)
        interface.addChild(exit)
    }
    
    func createUpgradeChoice (typeList: [String], interface: UpgradeInterface) {
        print(interface.selectedPiece.belong, typeList)
        var i = 0
        for type in typeList {
            var imageName = ""
            if interface.selectedPiece.belong == 0 {
                imageName = "White_\(type)"
            } else if interface.selectedPiece.belong == 1 {
                imageName = "Black_\(type)"
            }
            
            let texture = SKTexture(imageNamed: imageName)
            let size = CGSize(width: interface.size.width / 3.2, height: interface.size.height * 0.7)
            let choice = UpgradeChoice(texture: texture, size: size, type: type)
            choice.zPosition = 1
            choice.position = CGPoint(x: interface.size.width * (CGFloat(i) - 1) / 3, y: 0)
            choice.name = "Player\(interface.selectedPiece.belong)'s Upgrade Choice"
            let label = SKLabelNode(fontNamed: "Avenir")
            label.horizontalAlignmentMode = .center
            label.verticalAlignmentMode = .center
            label.fontSize = 25
            label.fontColor = .black
            label.text = "\(PieceCosts[type]!)"
            label.zPosition = 1
            label.position = CGPoint(x: 0, y: -choice.size.height * 0.5)
            label.name = "Cost"
            choice.addChild(label)
            interface.addChild(choice)
            i+=1
        }
    }
    
    func createUpgradePoint() {
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
            point.zRotation = MLPi * CGFloat(i)
            upGradePointDisplay.append(point)
            self.addChild(point)
        }
    }
    
    func refreshPoint(belong: Int) {
        let label = (upGradePointDisplay[belong].childNode(withName: "Player\(belong)'s Point") as! SKLabelNode)
        label.text = String(upGradePoint[belong])
    }
    
    func gameStart() {
        print("Game Start!")
        let chessGameScene = ChessGameScene(size: self.size)
        chessGameScene.scaleMode = self.scaleMode
        
        chessGameScene.board = self.board
        self.view?.presentScene(chessGameScene)
        self.removeFromParent()
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
                createUpgradeInterface(piece: touchedPiece, typeList: touchedType)
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
            } else if touchedNode.name == "Player0's Upgrade Choice" {
                if let choice = (touchedNode as? UpgradeChoice) {
                    if let costLabel = (choice.childNode(withName: "Cost") as? SKLabelNode) {
                        let interface = self.childNode(withName: "Player0's Interface") as! UpgradeInterface
                        let cost = Int(costLabel.text!)! - interface.selectedPiece.cost
                        if upGradePoint[0] - cost >= 0 {
                            choice.changePiece()
                            upGradePoint[0] -= cost
                            refreshPoint(belong: 0)
                            interface.removeFromParent()
                        } else {
                            print("Unaffordable for player 0")
                        }
                    }
                }
            } else if touchedNode.name == "Player1's Upgrade Choice" {
                if let choice = (touchedNode as? UpgradeChoice) {
                    if let costLabel = (choice.childNode(withName: "Cost") as? SKLabelNode) {
                        let interface = self.childNode(withName: "Player1's Interface") as! UpgradeInterface
                        let cost = Int(costLabel.text!)! - interface.selectedPiece.cost
                        if upGradePoint[1] >= cost {
                            choice.changePiece()
                            upGradePoint[1] -= cost
                            refreshPoint(belong: 1)
                            if let interface = self.childNode(withName: "Player1's Interface"){
                                interface.removeFromParent()
                            }
                        } else {
                            print("Unaffordable for player 1")
                        }
                    }
                }
            } else if touchedNode.name == "Player0's Confirm" {
                confirm_0 = !confirm_0
                if confirm_0 && confirm_1 {
                    gameStart()
                }
            } else if touchedNode.name == "Player1's Confirm" {
                confirm_1 = !confirm_1
                if confirm_0 && confirm_1 {
                    gameStart()
                }
            }
        }
    }
}
