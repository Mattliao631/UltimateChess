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

func *(lhs: Int, rhs: ChessboardCoordinate) ->ChessboardCoordinate {
    return ChessboardCoordinate(rank: rhs.rank * lhs, file: rhs.file * lhs)
}

func *(lhs: ChessboardCoordinate, rhs: Int) ->ChessboardCoordinate {
    return ChessboardCoordinate(rank: lhs.rank * rhs, file: lhs.file * rhs)
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

let ChessTypes = [
    "King": ["King", "Conqueror", "Underworld_Lord"],
    "Queen": ["Queen", "The_Fantasy", "Rose_Queen"],
    "Bishop": ["Bishop", "Divine_Blessed", "Space_Grimoire"],
    "Knight": ["Knight", "Unicorn", "Pegasus_Rider"],
    "Rook": ["Rook", "Brave_Flag", "The_Indestrucible"],
    "Pawn": ["Pawn", "Rose_Garden_Guard", "Zombie"]
]

let boardLowerBound = ChessboardCoordinate(rank: 0, file: 0)
let boardUpperBound = ChessboardCoordinate(rank: 11, file: 9)

func boundCheck(_ position: ChessboardCoordinate) -> Bool {
    return boardLowerBound <= position && position <= boardUpperBound
}


//兵的計算
func PawnMove(piece: ChessPiece, board: Board) {
    //初始化位置與方向資訊
    var startRank = 0
    var direction = ChessboardCoordinate()
    
    if piece.belong == 0 {
        startRank = 1
        direction = ChessboardCoordinate(rank: 1)
    } else if piece.belong == 1 {
        startRank = 10
        direction = ChessboardCoordinate(rank: -1)
    }
    
    //向前走一格判定
    let foward = piece.currentSquare!.boardCoordinate + (direction)
    if boundCheck(foward) {
        let fowardSquare = board.getSquare(foward)
        if !fowardSquare.hasPiece {
            piece.movableSquares.append(fowardSquare)
            
            //向前跳兩格（第一步）判定
            if piece.currentSquare?.boardCoordinate.rank == startRank{
                let jumpTo = piece.currentSquare!.boardCoordinate + (2 * direction)
                if boundCheck(jumpTo) {
                    let jumpToSquare = board.getSquare(jumpTo)
                    if !jumpToSquare.hasPiece {
                        piece.movableSquares.append(jumpToSquare)
                    }
                }
            }
        }
    }
    
    
    //斜吃判定
    let take1 = piece.currentSquare!.boardCoordinate + direction + ChessboardCoordinate(file: 1)
    let take2 = piece.currentSquare!.boardCoordinate + direction + ChessboardCoordinate(file: -1)
    
    //往右邊吃（以白方視角）
    if boundCheck(take1) {
        let takeSquare = board.getSquare(take1)
        if takeSquare.hasPiece && takeSquare.piece!.takable && takeSquare.piece!.belong != piece.belong {
            piece.takableSquares.append(takeSquare)
        }
    }
    //往左邊吃（以白方視角）
    if boundCheck(take2) {
        let takeSquare = board.getSquare(take2)
        if takeSquare.hasPiece && takeSquare.piece!.takable && takeSquare.piece!.belong != piece.belong {
            piece.takableSquares.append(takeSquare)
        }
    }
    
    //En Passant 判定
    let EnPassant1 = piece.currentSquare!.boardCoordinate + ChessboardCoordinate(file: 1)
    let EnPassant2 = piece.currentSquare!.boardCoordinate + ChessboardCoordinate(file: -1)
    
    
    //判斷旁邊是否有剛跳完的兵，如果有則將斜前方加入可移動格子（觸發移動時再判定將En Passant的敵方士兵消除
    if boundCheck(take1) && boundCheck(EnPassant1) {
        let EnPassantSquare = board.getSquare(EnPassant1)
        if EnPassantSquare.hasPiece &&  EnPassantSquare.piece!.takable && EnPassantSquare.piece!.belong != piece.belong {
            if let tempPawn = (EnPassantSquare.piece as? Pawn) {
                if tempPawn.canBeEnPassant {
                    let takeSquare = board.getSquare(take1)
                    piece.movableSquares.append(takeSquare)
                }
            }
        }
    }
    if boundCheck(take2) && boundCheck(EnPassant2) {
        let EnPassantSquare = board.getSquare(EnPassant2)
        if EnPassantSquare.hasPiece &&  EnPassantSquare.piece!.takable && EnPassantSquare.piece!.belong != piece.belong {
            if let tempPawn = (EnPassantSquare.piece as? Pawn) {
                if tempPawn.canBeEnPassant {
                    let takeSquare = board.getSquare(take2)
                    piece.movableSquares.append(takeSquare)
                }
            }
        }
    }
}


//王的計算
func KingMove(piece: ChessPiece, board: Board) {
    //建立方向表
    let kingMoveDirection = [
        ChessboardCoordinate(file: 1),
        ChessboardCoordinate(rank: 1),
        ChessboardCoordinate(file: -1),
        ChessboardCoordinate(rank: -1),
        ChessboardCoordinate(rank: 1, file: 1),
        ChessboardCoordinate(rank: 1, file: -1),
        ChessboardCoordinate(rank: -1, file: 1),
        ChessboardCoordinate(rank: -1, file: -1)
    ]
    
    //遍歷方向表找出可走與可吃的格子
    for direction in kingMoveDirection {
        let goingTo = piece.currentSquare!.boardCoordinate + direction
        if boundCheck(goingTo) {
            let toSquare = board.getSquare(goingTo)
            
            if toSquare.hasPiece {
                if toSquare.piece!.takable && toSquare.piece!.belong != piece.belong {
                    piece.takableSquares.append(toSquare)
                }
            } else {
                piece.movableSquares.append(toSquare)
            }
        }
    }
}


//主教的計算
func BishopMove(piece: ChessPiece, board: Board) {
    //建立主教移動方向
    let bishopMoveDirections = [
        ChessboardCoordinate(rank: 1, file: -1),
        ChessboardCoordinate(rank: -1, file: 1),
        ChessboardCoordinate(rank: 1, file: 1),
        ChessboardCoordinate(rank: -1, file: -1)
    ]
    
    //遍歷方向與深度收集所有可移動格子
    for direction in bishopMoveDirections {
        for i in 1...9 {
            let goingTo = piece.currentSquare!.boardCoordinate + i * direction
            if boundCheck(goingTo) {
                let toSquare = board.getSquare(goingTo)
                
                if toSquare.hasPiece {
                    if toSquare.piece!.takable && toSquare.piece!.belong != piece.belong {
                        piece.takableSquares.append(toSquare)
                    }
                    break
                } else {
                    piece.movableSquares.append(toSquare)
                }
            } else {
                break
            }
        }
    }
}


//空間魔導書的計算
func SpaceGrimoireMove(piece: ChessPiece, board: Board) {
    //建立主教移動方向
    let bishopMoveDirections = [
        ChessboardCoordinate(rank: 1, file: -1),
        ChessboardCoordinate(rank: -1, file: 1),
        ChessboardCoordinate(rank: 1, file: 1),
        ChessboardCoordinate(rank: -1, file: -1)
    ]
    
    //無視阻擋的遍歷
    for direction in bishopMoveDirections {
        for i in 1...9 {
            let goingTo = piece.currentSquare!.boardCoordinate + i * direction
            if boundCheck(goingTo) {
                let toSquare = board.getSquare(goingTo)
                if toSquare.hasPiece {
                    if toSquare.piece!.takable && toSquare.piece!.belong != piece.belong {
                        piece.takableSquares.append(toSquare)
                    }
                } else {
                    piece.movableSquares.append(toSquare)
                }
            } else {
                break
            }
        }
    }
}

//城堡的計算
func RookMove(piece: ChessPiece, board: Board) {
    let rookMoveDirections = [
        ChessboardCoordinate(rank: 1),
        ChessboardCoordinate(rank: -1),
        ChessboardCoordinate(file: 1),
        ChessboardCoordinate(file: -1)
    ]
    
    //遍歷方向與深度收集所有可移動格子
    for direction in rookMoveDirections {
        for i in 1...11 {
            let goingTo = piece.currentSquare!.boardCoordinate + i * direction
            if boundCheck(goingTo) {
                let toSquare = board.getSquare(goingTo)
                
                if toSquare.hasPiece {
                    if toSquare.piece!.takable && toSquare.piece!.belong != piece.belong {
                        piece.takableSquares.append(toSquare)
                    }
                    break //遇到棋子擋住去路所以不再深入
                } else {
                    piece.movableSquares.append(toSquare)
                }
            } else {
                break
            }
        }
    }
}


//皇后的計算
func QueenMove(piece: ChessPiece, board: Board) {
    //偷吃步用主教的加上城堡的來完成
    RookMove(piece: piece, board: board)
    BishopMove(piece: piece, board: board)
}


//騎士的計算
func KnightMove(piece: ChessPiece, board: Board) {
    //建立騎士移動方向
    let knightMoveDirections = [
        ChessboardCoordinate(rank: 2, file: 1),
        ChessboardCoordinate(rank: 2, file: -1),
        ChessboardCoordinate(rank: -2, file: 1),
        ChessboardCoordinate(rank: -2, file: -1),
        ChessboardCoordinate(rank: 1, file: 2),
        ChessboardCoordinate(rank: 1, file: -2),
        ChessboardCoordinate(rank: -1, file: 2),
        ChessboardCoordinate(rank: -1, file: -2)
    ]
    for direction in knightMoveDirections {
        let goingTo = piece.currentSquare!.boardCoordinate + direction
        if boundCheck(goingTo) {
            let toSquare = board.getSquare(goingTo)
            
            if toSquare.hasPiece && toSquare.piece!.belong != piece.belong {
                if toSquare.piece!.takable {
                    piece.takableSquares.append(toSquare)
                }
            } else {
                piece.movableSquares.append(toSquare)
            }
        }
    }
}

//天馬騎士的計算
func PegasusRiderMove(piece: ChessPiece, board: Board) {
    //建立騎士移動方向
    let knightMoveDirections = [
        ChessboardCoordinate(rank: 2, file: 1),
        ChessboardCoordinate(rank: 2, file: -1),
        ChessboardCoordinate(rank: -2, file: 1),
        ChessboardCoordinate(rank: -2, file: -1),
        ChessboardCoordinate(rank: 1, file: 2),
        ChessboardCoordinate(rank: 1, file: -2),
        ChessboardCoordinate(rank: -1, file: 2),
        ChessboardCoordinate(rank: -1, file: -2)
    ]
    
    //延展遍歷
    for direction in knightMoveDirections {
        for i in 1...2 {
            let goingTo = piece.currentSquare!.boardCoordinate + i * direction
            if boundCheck(goingTo) {
                let toSquare = board.getSquare(goingTo)
                
                if toSquare.hasPiece {
                    if toSquare.piece!.takable && toSquare.piece!.belong != piece.belong {
                        piece.takableSquares.append(toSquare)
                    }
                } else {
                    piece.movableSquares.append(toSquare)
                }
            }
        }
    }
}
