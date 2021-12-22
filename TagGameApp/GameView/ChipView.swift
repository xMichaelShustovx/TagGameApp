//
//  PlateView.swift
//  TagGameApp
//
//  Created by Michael Shustov on 09.12.2021.
//

import UIKit

class ChipView: UIView {

    //MARK: - Properties and variables
    
    let gameChip: GameChip
    
    lazy var numberLabel: UILabel = {
        let result = UILabel()
        result.textColor = .white
        result.font = UIFont.systemFont(ofSize: 20)
        result.textAlignment = .center
        return result
    }()
    
    //MARK: - Initialization
    
    init(gameChip: GameChip) {
        self.gameChip = gameChip
        super.init(frame: CGRect())

        self.customizeChip()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func customizeChip() {
        
        self.layer.cornerRadius = 15
        
        
        // Customize chip according to its property
        switch gameChip {
            
        case .button(let number):
            self.backgroundColor = .darkGray
            self.numberLabel.text = String(number)
            self.numberLabel.frame = CGRect(origin: .zero, size: CGSize(width: 60, height: 60))
            self.addSubview(numberLabel)
            
        case .emptySpace:
            self.backgroundColor = .yellow
        }
    }
}
