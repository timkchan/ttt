//
//  ViewController.swift
//  ttt
//
//  Created by Tim Kit Chan on 10/01/16.
//  Copyright © 2016 AppBee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var winningCombos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    var turn = 1 // 1 = o; -1 = x
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var state = 0
    
    

    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBAction func replayButtonPressed(_ sender: AnyObject) {
        reset()
    }
    @IBAction func buttonPressed(_ sender: AnyObject) {
        //A way to disable a button
        //let disableMyButton = sender as? UIButton
        //disableMyButton!.enabled = false
        
        if (gameState[sender.tag] == 0 && state == 0) {
            
            sender.setImage(UIImage(named: (turn > 0 ? "o.png" : "x.png")), for: UIControlState())
            gameState[sender.tag] = turn
            state = checkWin()
            if (state == 0) {
                turn = -turn
            } else {
                
                if (abs(state) == 1) {
                    
                    gameOverLabel.text = "\(state == 1 ? "O" : "X") has won!"
                } else {
                    gameOverLabel.text = "draw!"
                }
                
                gameOverLabel.isHidden = false
                replayButton.isHidden = false
                
                UIView.animate(withDuration: 1 , animations: { () -> Void in
                    self.replayButton.center = CGPoint(x: self.replayButton.center.x + 500, y: self.replayButton.center.y)
                })
            }
        }
    }
    
    func reset() {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        turn = 1
        state = 0
        gameOverLabel.isHidden = true
        replayButton.isHidden = true
        gameOverLabel.center = CGPoint(x: replayButton.center.x - 500, y: replayButton.center.y)
        var buttonToClear : UIButton
        for x in 0...8 {
            buttonToClear = view.viewWithTag(x) as! UIButton
            buttonToClear.setImage(nil, for: UIControlState())
        }
    }
    
    
    func checkWin() -> Int {
        for winningCombo in winningCombos {
            var state = 0
            for x in winningCombo {
                state += gameState[x]
            }
            if abs(state) == 3 {return turn}
        }
        let isDraw = gameState.reduce(1) {$0 * $1}
        print(gameState)
        if (isDraw != 0) {
            return 2
        }
        return 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameOverLabel.isHidden = true
        replayButton.isHidden = true
        gameOverLabel.center = CGPoint(x: replayButton.center.x - 500, y: replayButton.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

