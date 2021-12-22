//
//  GameView.swift
//  TagGameApp
//
//  Created by Michael Shustov on 09.12.2021.
//

import UIKit

class GameView: UIView {

    // MARK: - Properties
    
    var board: [[GameChip]]
    
    let handler: ((GameChip) -> Bool)
    
    var chipViews = [ChipView]()
    
    // MARK: - Initialization
    
    init(board: [[GameChip]], nextStepHandler: @escaping(GameChip) -> Bool) {
        self.board = board
        self.handler = nextStepHandler
        super.init(frame: CGRect())
        
        self.customizeView()
        self.customizeGameChips()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler(recognizer:)))
        self.addGestureRecognizer(recognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func customizeView() {
        
        // Set self view frame and background color
        self.frame.size = CGSize(width: 270, height: 270)
        self.backgroundColor = .clear
    }
    
    private func customizeGameChips() {
        
        // Set chips views
        let chipSize = CGSize(width: 60, height: 60)
        let chipOffset = CGPoint(x: 10, y: 10)
        var chipOrigin = CGPoint(x: 0, y: 0)
        
        var counter = 0
        
        for i in 0..<board.count {
            for j in 0..<board[i].count {
                
                let chip = ChipView(gameChip: board[i][j])
                chip.frame.origin = chipOrigin
                chip.frame.size = chipSize
                
                self.chipViews.append(chip)
                
                self.addSubview(chip)
                
                chipOrigin.x += (chipSize.width + chipOffset.x)
                counter += 1
            }
            
            chipOrigin.x = 0
            chipOrigin.y += (chipSize.height + chipOffset.y)
        }
    }
    
    @objc
    private func tapHandler(recognizer: UITapGestureRecognizer) {
        
        // Get location of users tap
        let location = recognizer.location(in: self)
        
        // Get chip view in case it was tapped
        let tappedView = self.hitTest(location, with: nil) as? ChipView
        
        guard tappedView != nil else {
            print("Not a Chip View!")
            return
        }
        
        // Ask model through VC if chip can be moved
        if self.handler(tappedView!.gameChip) {
            
            // Get empty chip to have access to its location
            let emptyChip = self.chipViews.first { chip in
                chip.gameChip == GameChip.emptySpace
            }
            
            guard emptyChip != nil else {
                return
            }
            
            // Change locations of the tapped chip and empty chip
            let tmpLocation = emptyChip!.frame.origin
            emptyChip!.frame.origin = tappedView!.frame.origin
            tappedView!.frame.origin = tmpLocation
            
        }
    }
}
