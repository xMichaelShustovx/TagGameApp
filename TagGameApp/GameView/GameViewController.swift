//
//  GameViewController.swift
//  TagGameApp
//
//  Created by Michael Shustov on 07.12.2021.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: Properties and variables
    
    let model = GameModel()
    
    lazy var gameView = GameView(board: model.board2d, nextStepHandler: self.nextStepHandler(tappedChip:))
    
    lazy var statView = StatisticsView()
    
    var timer: Timer?
    
    // MARK: Life Cycle
    
    override func loadView() {
        super.loadView()
        
        // Customize view
        self.view.backgroundColor = UIColor(named: "BackgroundColor")
        
        // Add Game View and set its origin
        gameView.center = self.view.center
        self.view.addSubview(gameView)
        
        // Add Statistics View and set its frame
        statView.frame.size = CGSize(width: 200, height: 140)
        statView.center.x = self.view.center.x
        statView.center.y = self.view.center.y - CGFloat(250)
        self.view.addSubview(statView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Start timer
        self.createTimer()
        if let timer = self.timer {
            RunLoop.main.add(timer, forMode: .common)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Stop timer on view disappear
        if let timer = self.timer {
            timer.invalidate()
        }
    }
    
    // MARK: - Private methods
    
    private func nextStepHandler(tappedChip: GameChip) -> Bool {
        
        defer  {
            if model.checkWin() {
                
                // Present Win Screen
                let winController = WinViewController()
                winController.modalPresentationStyle = .fullScreen
                present(winController, animated: true, completion: nil)
                
                // Stop timer
                if let timer = self.timer {
                    timer.invalidate()
                }
            }
        }
        
        // Ask model if the move is ligit
        if self.model.moveChip(chip: tappedChip) {
            
            // Increment number of moves
            self.statView.incrementCounter()
            
            return true
        }
        else {
            return false
        }
    }
    
    private func createTimer() {
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.timerFired), userInfo: nil, repeats: true)
    }
    
    @objc
    private func timerFired() {
        
        self.statView.timerFired()
    }
}
