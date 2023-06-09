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
    var longPressTime: TimeInterval?
    override func didMove(to view: SKView) {
        //print("Transition succeed!")
        createButtons()
        createBoard()
        
    }
    
    
    func createBoard() {
        let texture = SKTexture(imageNamed: "ChessBoard")
        board = Board(texture: texture, size: self.size)
        board.name = "ChessBoard"
        board.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        board.zPosition = -2
        self.addChild(board)
        createSquares()
    }
    
    func createSquares() {
        for rank in boardLowerBound.rank...boardUpperBound.rank {
            var tempRank = [Square]()
            for file in boardLowerBound.file...boardUpperBound.file {
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
                    square.piece = piece
                    square.hasPiece = true
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
            confirm.texture = SKTexture(imageNamed: "Confirm_Button")
            confirm.zPosition = 1
            confirm.zRotation = MLPi * CGFloat(i)
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
        //print(interface.selectedPiece.belong, typeList)
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
            let choice = UpgradeChoice(texture: texture, size: size, type: type, belong: interface.selectedPiece.belong)
            choice.zPosition = 1
            choice.position = CGPoint(x: interface.size.width * (CGFloat(i) - 1) / 3, y: 0)
            choice.name = "Player\(interface.selectedPiece.belong)'s Upgrade Choice"
            let label = SKLabelNode(fontNamed: "Avenir")
            label.horizontalAlignmentMode = .center
            label.verticalAlignmentMode = .center
            label.fontSize = 25
            label.fontColor = .black
            label.text = "\(PieceCosts[type]!)"
            label.position = CGPoint(x: 0, y: -choice.size.height * 0.5)
            label.name = "Cost"
            label.zPosition = 1
            choice.addChild(label)
            interface.addChild(choice)
            i+=1
        }
    }
    
    func createUpgradePoint() {
        for i in 0...(numberOfPlayers-1) {
            upGradePoint.append(40)
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
        //print("Game Start!")
        let chessGameScene = ChessGameScene(size: self.size)
        chessGameScene.scaleMode = self.scaleMode
        GameManager.board = self.board
        board.removeFromParent()
        
        let trans = SKTransition.crossFade(withDuration: 1)
        
        self.view?.presentScene(chessGameScene, transition: trans)
        self.removeFromParent()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.longPressTime = touches.first?.timestamp
        let touch = touches.first!
        let location = touch.location(in: self)
        let node = atPoint(location)
        //print(node)
        if let choice = node as? UpgradeChoice {
            //print("??")
            let label = SKLabelNode(text: PieceExplainations[choice.type])
            //print(label.text)
            label.verticalAlignmentMode = .center
            label.fontName = "Avenir"
            label.fontSize = 18
            label.numberOfLines = 5
            label.preferredMaxLayoutWidth = self.frame.width
            label.fontColor = .black
            label.zPosition = 1
            label.zRotation = MLPi * CGFloat(choice.belong)
            label.name = "Explaination\(choice.belong)"
            let background = SKSpriteNode(color: .white, size: CGSize(width: self.frame.width, height: self.frame.width * 0.4))
            background.texture = SKTexture(imageNamed: "Confirm_Button")
            background.position = CGPoint(x: 0, y: (0.4 * CGFloat(choice.belong) - 0.2) * self.frame.midY)
            background.zPosition = 10
            background.name = "Explaination\(choice.belong)"
            background.addChild(label)
            board.addChild(background)
        }
        //print(self.longPressTime)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        //print((touches.first?.timestamp)!)
        //print(self.longPressTime)
        let touch = touches.first!
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)
        if let choice = touchedNode as? UpgradeChoice {
            if let explaination = board.childNode(withName: "Explaination\(choice.belong)") {
                explaination.removeFromParent()
            }
        } else if touchedNode.name == "Explaination0" || touchedNode.name == "Explaination1" {
            
            if touchedNode.parent?.name == "Explaination0" || touchedNode.parent?.name == "Explaination1" {
                touchedNode.parent?.removeFromParent()
            } else {
                touchedNode.removeFromParent()
            }
        }
        
        
        if let time = self.longPressTime {
            let touchDuration = (touches.first?.timestamp)! - time
            //print(touchDuration)
            if touchDuration >= 0.2 {
                
                return
            }
        }
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if let touchedPiece = touchedNode as? ChessPiece {
                if let existingInterface = self.childNode(withName: "Player\(touchedPiece.belong)'s Interface") as? UpgradeInterface {
                    existingInterface.removeFromParent()
                }
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
                let MainMenuScene = MainMenuScene(size: self.size)
                MainMenuScene.scaleMode = self.scaleMode
                let trans = SKTransition.flipVertical(withDuration: 1)
                self.view?.presentScene(MainMenuScene, transition: trans)
                self.removeFromParent()
            } else if touchedNode.name == "Player0's Interface Exit" {
                if let interface = self.childNode(withName: "Player0's Interface") {
                    interface.removeFromParent()
                }
            } else if touchedNode.name == "Player1's Interface Exit" {
                if let interface = self.childNode(withName: "Player1's Interface") {
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
                            //print("Unaffordable for player 0")
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
                            //print("Unaffordable for player 1")
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
            return
        }
    }
}
