//
//  WinView.swift
//  TagGameApp
//
//  Created by Michael Shustov on 16.12.2021.
//

import UIKit

class WinView: UIStackView {

    // MARK: - Properties and variables
    
    typealias CloseHandler = () -> Void
    
    let handler: CloseHandler
    
    // MARK: - Initialization
    
    init(handler: @escaping CloseHandler) {
        self.handler = handler
        super.init(frame: .zero)
        
        // Set Stack View properties
        self.axis = .vertical
        self.alignment = .center
        self.spacing = 30
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor(named: "BackgroundColor")
        
        // Add a message for the user
        let winMessage = UILabel()
        self.customizeWinMessage(label: winMessage)
        self.addArrangedSubview(winMessage)
        
        // TODO: Add buttons to start new game and return to the launch view
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func customizeWinMessage(label: UILabel) {
        
        label.text = "Congratulations!\nYou are winner!"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 23)
        label.textAlignment = .center
        
        label.frame.size = CGSize(width: 200, height: 50)
    }
}
