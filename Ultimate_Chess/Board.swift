//
//  Board.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/21.
//

import UIKit
import SpriteKit


class Board: SKSpriteNode {
    
    var view: SKView?
    var squares = [[Square]]()
    
    var square: Square?
    init() {
        
        super.init(texture: SKTexture(imageNamed: "ChessBoard"), color: .orange, size: view?.frame.size ?? CGSize())
        
        let w = CGFloat(((view?.frame.width)!) / 10)
        let squareSize = CGSize(width: w, height: w)
        for i in 0...11 {
            for j in 0...9 {
                square = Square(rank: i, file: j, size: squareSize)
//                print(square?.squareSize, square!.position, square?.boardCoordinate.file, square?.boardCoordinate.rank)
                self.addChild(square!)
            }
        }
        //給出square具體大小
//        let w = CGFloat((view?.frame.width ?? 0) / 10)
//        let squareSize = CGSize(width: w, height: w)
//
//        for file in 0...9 {
//            var tempFile = [Square]()
//            for rank in 0...11 {
//                tempFile.append(Square(rank: rank, file: file, size: squareSize))
//                if let str = UltimateChessMapping["\(rank),\(file)"] {
//                    var piece: ChessPiece?
//                    switch str {
//                    case "White_Rook":
//                        piece = ChessPiece()
//                    default:
//                        break
//                    }
//                    tempFile[rank].addChild(piece!)
//                }
//            }
//            squares.append(tempFile)
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
