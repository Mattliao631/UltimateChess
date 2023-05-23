//
//  Board.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/21.
//

import UIKit
import SpriteKit


class Board: SKSpriteNode {
    
    var squares = [[Square]]()
    
    init(size: CGSize) {
        
        super.init(texture: SKTexture(imageNamed: "ChessBoard"), color: .orange, size: size)
        self.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        
        //給出square具體大小

        for rank in 0...11 {
            var tempRank = [Square]()
            for file in 0...9 {
                tempRank.append(Square(rank: rank, file: file, size: self.size))
                //print(UltimateChessMapping["(\(rank),\(file))"] ?? "\(rank),\(file) not found")
                
                if let str = UltimateChessMapping["(\(rank),\(file))"] {
                    //print("(\(rank),\(file))", str)
                    var piece: ChessPiece?
                    switch str {
                    case "White_Pawn":
                        piece = Pawn(belong: 0, name: str, square: tempRank[file])
                        break
                    case "White_Rook":
                        piece = Rook(belong: 0, name: str, square: tempRank[file])
                        break
                    case "White_Knight":
                        piece = Knight(belong: 0, name: str, square: tempRank[file])
                        break
                    case "White_Bishop":
                        piece = Bishop(belong: 0, name: str, square: tempRank[file])
                        break
                    case "White_Queen":
                        piece = Queen(belong: 0, name: str, square: tempRank[file])
                        break
                    case "White_King":
                        piece = King(belong: 0, name: str, square: tempRank[file])
                        break
                    case "Black_Pawn":
                        piece = Pawn(belong: 1, name: str, square: tempRank[file])
                        break
                    case "Black_Rook":
                        piece = Rook(belong: 1, name: str, square: tempRank[file])
                        break
                    case "Black_Knight":
                        piece = Knight(belong: 1, name: str, square: tempRank[file])
                        break
                    case "Black_Bishop":
                        piece = Bishop(belong: 1, name: str, square: tempRank[file])
                        break
                    case "Black_Queen":
                        piece = Queen(belong: 1, name: str, square: tempRank[file])
                        break
                    case "Black_King":
                        piece = King(belong: 1, name: str, square: tempRank[file])
                        break
                    default:
                        break
                    }
                    piece?.name = "ChessPiece"
                    piece?.zPosition = 2
                    //print("(\(rank),\(file))", piece!)
                    tempRank[file].addChild(piece!)
                    tempRank[file].hasPiece = true
                    tempRank[file].piece = piece
                }
            }
            squares.append(tempRank)
        }
        for rank in squares {
            for file in rank {
                self.addChild(file)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSquare(_ coordinate: ChessboardCoordinate) -> Square {
        return squares[coordinate.rank][coordinate.file]
    }
}
