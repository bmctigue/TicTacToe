//
//  Interactor.swift
//  TicTacToe
//
//  Created by Bruce McTigue on 8/27/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation
import UIKit

class Interactor {
    
    weak var controller: ViewController!
    
    init(controller: ViewController) {
        self.controller = controller
    }
    
    func autoPlay() {
        controller.auto.isEnabled = false
        let random = Int(arc4random_uniform(UInt32(controller.board.position.count)) + 1)
        let button = UIButton()
        button.tag = random
        controller.piecePressed(button)
        var gameInProgress = true
        while gameInProgress {
            let bestMove = controller.board.findBestMove(controller.board)
            let button = UIButton()
            button.tag = bestMove
            controller.piecePressed(button)
            gameInProgress = !(controller.board.isWin || controller.board.isDraw)
        }
    }
    
    func updateBoard() {
        for i in 0..<controller.board.position.count {
            let piece = controller.board.position[i]
            switch(piece) {
            case .X:
                controller.buttons[i].isEnabled = false
                controller.labels[i].textColor = UIColor.red
            case .O:
                controller.buttons[i].isEnabled = false
                controller.labels[i].textColor = UIColor.black
            default:
                controller.buttons[i].isEnabled = true
            }
            controller.labels[i].text = piece.rawValue
        }
    }
    
    func updateGameStatus() {
        if controller.board.isWin {
            controller.resultLabel.text = ViewController.winText
            controller.resultLabel.textColor = UIColor.green
            disableAllButtons()
        } else if controller.board.isDraw {
            controller.resultLabel.text = ViewController.drawText
            controller.resultLabel.textColor = UIColor.black
            disableAllButtons()
        } else {
            controller.resultLabel.text = ViewController.defaultText
        }
    }
    
    func disableAllButtons() {
        for i in 0..<controller.board.position.count {
            controller.buttons[i].isEnabled = false
        }
        controller.suggest.isEnabled = false
    }
    
    func resetResultLabel() {
        controller.resultLabel.text = ViewController.defaultText
        controller.resultLabel.textColor = UIColor.black
    }
    
    func resetCellBorders() {
        let borderColor = UIColor.black.cgColor
        controller.boardView.layer.borderColor = borderColor
        controller.boardView.layer.borderWidth = 2.0
        for label in controller.labels {
            label.layer.borderColor = borderColor
            label.layer.borderWidth = 1.0
        }
    }
    
    func resetCellBackgroundColor() {
        for label in controller.labels {
            label.backgroundColor = UIColor.white
        }
    }
}
