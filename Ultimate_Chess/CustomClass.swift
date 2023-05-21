//
//  CustomClass.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/21.
//

import Foundation


func +(lhs: ChessboardCoordinate, rhs: ChessboardCoordinate)->ChessboardCoordinate {
    let newCoordinate = ChessboardCoordinate(rank: lhs.rank+rhs.rank, file: lhs.file+rhs.file)
    return newCoordinate
}

func -(lhs: ChessboardCoordinate, rhs: ChessboardCoordinate)->ChessboardCoordinate {
    let newCoordinate = ChessboardCoordinate(rank: lhs.rank-rhs.rank, file: lhs.file-rhs.file)
    return newCoordinate
}

func >=(lhs: ChessboardCoordinate, rhs: ChessboardCoordinate) -> Bool {
    if lhs.rank >= rhs.rank && lhs.file >= rhs.file {
        return true
    }
    return false
}

func >(lhs: ChessboardCoordinate, rhs: ChessboardCoordinate) -> Bool {
    if lhs.rank > rhs.rank && lhs.file > rhs.file {
        return true
    }
    return false
}

func <=(lhs: ChessboardCoordinate, rhs: ChessboardCoordinate) -> Bool {
    if lhs.rank <= rhs.rank && lhs.file <= rhs.file {
        return true
    }
    return false
}

func <(lhs: ChessboardCoordinate, rhs: ChessboardCoordinate) -> Bool {
    if lhs.rank < rhs.rank && lhs.file < rhs.file {
        return true
    }
    return false
}

func ==(lhs: ChessboardCoordinate, rhs: ChessboardCoordinate) -> Bool {
    if lhs.rank == rhs.rank && lhs.file == rhs.file {
        return true
    }
    return false
}

class ChessboardCoordinate {
    var rank: Int = 0
    var file: Int = 0
    
    init() {
        rank = 0
        file = 0
    }
    init(rank: Int, file: Int) {
        self.rank = rank
        self.file = file
    }
    init(rank: Int) {
        self.rank = rank
        self.file = 0
    }
    init(file: Int) {
        self.rank = 0
        self.file = file
    }
    init(cp: ChessboardCoordinate) {
        self.rank = cp.rank
        self.file = cp.file
    }
    
}

var UltimateChessMapping = [
    "(0,0)": "White_Rook",
    "(0,1)": "White_Knight",
    "(0,2)": "White_Bishop",
    "(0,3)": "White_Knight",
    "(0,4)": "White_King",
    "(0,5)": "White_Queen",
    "(0,6)": "White_Bishop",
    "(0,7)": "White_Knight",
    "(0,8)": "White_Bishop",
    "(0,9)": "White_Rook",
    
    "(1,0)": "White_Pawn",
    "(1,1)": "White_Pawn",
    "(1,2)": "White_Pawn",
    "(1,3)": "White_Pawn",
    "(1,4)": "White_Pawn",
    "(1,5)": "White_Pawn",
    "(1,6)": "White_Pawn",
    "(1,7)": "White_Pawn",
    "(1,8)": "White_Pawn",
    "(1,9)": "White_Pawn",
    
    "(11,0)": "Black_Rook",
    "(11,1)": "Black_Knight",
    "(11,2)": "Black_Bishop",
    "(11,3)": "Black_Knight",
    "(11,4)": "Black_King",
    "(11,5)": "Black_Queen",
    "(11,6)": "Black_Bishop",
    "(11,7)": "Black_Knight",
    "(11,8)": "Black_Bishop",
    "(11,9)": "Black_Rook",
    
    "(10,0)": "Black_Pawn",
    "(10,1)": "Black_Pawn",
    "(10,2)": "Black_Pawn",
    "(10,3)": "Black_Pawn",
    "(10,4)": "Black_Pawn",
    "(10,5)": "Black_Pawn",
    "(10,6)": "Black_Pawn",
    "(10,7)": "Black_Pawn",
    "(10,8)": "Black_Pawn",
    "(10,9)": "Black_Pawn",
]
