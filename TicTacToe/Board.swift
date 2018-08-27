//
//  Board.swift
//  TicTacToe
//
//  Created by Bruce McTigue on 8/27/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation
import UIKit

typealias Move = Int

struct Board {
    let position: [Piece]
    let turn: Piece
    let lastMove: Move

    init(position: [Piece] = [.E, .E, .E, .E, .E, .E, .E, .E, .E], turn: Piece = .X, lastMove: Int = -1) {
        self.position = position
        self.turn = turn
        self.lastMove = lastMove
    }
    
    func move(_ location: Move) -> Board {
        var tempPosition = position
        tempPosition[location] = turn
        return Board(position: tempPosition, turn: turn.opposite, lastMove: location)
    }
    
    var legalMoves: [Move] {
        return position.indices.filter { position[$0] == .E }
    }
    
    func isLegalMove(_ move: Move) -> Bool {
        return legalMoves.contains(move)
    }
    
    var isWin: Bool {
        return
            position[0] == position[1] && position[0] == position[2] && position[0] != .E ||
            position[3] == position[4] && position[3] == position[5] && position[3] != .E ||
            position[6] == position[7] && position[6] == position[8] && position[6] != .E ||
            position[0] == position[3] && position[0] == position[6] && position[0] != .E ||
            position[1] == position[4] && position[1] == position[7] && position[1] != .E ||
            position[2] == position[5] && position[2] == position[8] && position[2] != .E ||
            position[0] == position[4] && position[0] == position[8] && position[0] != .E ||
            position[2] == position[4] && position[2] == position[6] && position[2] != .E
    }
    
    var isDraw: Bool {
        return !isWin && legalMoves.count == 0
    }
    
    func minimax(_ board: Board, maximizing: Bool, originalPlayer: Piece) -> Int {
        // Base case — evaluate the position if it is a win or a draw
        if board.isWin && originalPlayer == board.turn.opposite { return 1 } // win
        else if board.isWin && originalPlayer != board.turn.opposite { return -1 } // loss
        else if board.isDraw { return 0 } // draw
        
        // Recursive case — maximize your gains or minimize the opponent's gains
        if maximizing {
            var bestEval = Int.min
            for move in board.legalMoves { // find the move with the highest evaluation
                let result = minimax(board.move(move), maximizing: false, originalPlayer: originalPlayer)
                bestEval = max(result, bestEval)
            }
            return bestEval
        } else { // minimizing
            var worstEval = Int.max
            for move in board.legalMoves {
                let result = minimax(board.move(move), maximizing: true, originalPlayer: originalPlayer)
                worstEval = min(result, worstEval)
            }
            return worstEval
        }
    }
    
    func findBestMove(_ board: Board) -> Move {
        var bestEval = Int.min
        var bestMove = -1
        for move in board.legalMoves {
            let result = minimax(board.move(move), maximizing: false, originalPlayer: board.turn)
            if result > bestEval {
                bestEval = result
                bestMove = move
            }
        }
        return bestMove
    }
}
