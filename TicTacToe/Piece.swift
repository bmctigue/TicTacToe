//
//  Piece.swift
//  TicTacToe
//
//  Created by Bruce McTigue on 8/27/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

enum Piece: String {
    case X = "X"
    case O = "O"
    case E = " "
    var opposite: Piece {
        switch self {
        case .X:
            return .O
        case .O:
            return .X
        case .E:
            return .E
        }
    }
}
