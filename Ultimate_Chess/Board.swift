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
        let w = CGFloat(size.width)
        let squareSize = CGSize(width: w, height: w)

        for rank in 0...11 {
            var tempRank = [Square]()
            for file in 0...9 {
                tempRank.append(Square(rank: rank, file: file, size: self.size))
                if let str = UltimateChessMapping["\(rank),\(file)"] {
                    var piece: ChessPiece?
                    switch str {
                    case "White_Rook":
                        piece = Rook(belong: 0, name: str, square: tempRank[file])
                    default:
                        break
                    }
                    piece?.name = str
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
