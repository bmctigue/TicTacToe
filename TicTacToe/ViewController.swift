//
//  ViewController.swift
//  TicTacToe
//
//  Created by Bruce McTigue on 8/27/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static var winText = "You Win!"
    static var drawText = "It's a Draw"
    static var defaultText = "Select a Square"
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    
    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var suggest: UIButton!
    @IBOutlet weak var auto: UIButton!
    
    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var board: Board!
    var buttons: [UIButton] = []
    var labels: [UILabel] = []
    var interactor: Interactor!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = Interactor(controller: self)
        self.board = Board()
        buttons = [button0,button1,button2,button3,button4,button5,button6,button7,button8]
        labels = [label0,label1,label2,label3,label4,label5,label6,label7,label8]
        interactor.resetCellBorders()
        newGamePressed(UIButton())
    }
    
    @IBAction func piecePressed(_ sender: Any) {
        let button = sender as! UIButton
        let move = button.tag
        if board.isLegalMove(move) {
            interactor.resetCellBackgroundColor()
            self.board = board.move(move)
            interactor.updateBoard()
            interactor.updateGameStatus()
        }
    }
    
    @IBAction func newGamePressed(_ sender: Any) {
        self.board = Board()
        interactor.updateBoard()
        interactor.resetResultLabel()
        interactor.resetCellBackgroundColor()
        auto.isEnabled = true
        suggest.isEnabled = true
    }
    
    @IBAction func suggestPressed(_ sender: Any) {
        let bestMove = board.findBestMove(board)
        let label = labels[bestMove]
        label.backgroundColor = UIColor.green
    }
    
    @IBAction func autoPressed(_ sender: Any) {
        interactor.autoPlay()
    }
}

