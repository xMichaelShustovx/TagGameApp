//
//  StatisticsView.swift
//  TagGameApp
//
//  Created by Michael Shustov on 16.12.2021.
//

import UIKit

class StatisticsView: UIStackView {

    // MARK: - Properties and variables
    
    var counter = 0
    var timeElapsed: Double = 0
    
    lazy var timerLabel: UILabel = {
       
        let result = UILabel()
        
        result.layer.cornerRadius = 15
        result.backgroundColor = .white
        result.clipsToBounds = true
        
        result.text = String(format: "  Time: %.2f", timeElapsed)
        result.font = UIFont.systemFont(ofSize: 21)
        result.textColor = .darkGray
        //result.frame.size = CGSize(width: 100, height: 50)
        result.translatesAutoresizingMaskIntoConstraints = false
        result.widthAnchor.constraint(equalToConstant: 200).isActive = true
        result.heightAnchor.constraint(equalToConstant: 60).isActive = true
        result.textAlignment = .left
        
        return result
    }()
    
    lazy var turnCounterLabel: UILabel = {
        
        let result = UILabel()
        
        result.layer.cornerRadius = 15
        result.backgroundColor = .white
        result.clipsToBounds = true
        
        result.text = "  Turns: \(counter)"
        result.font = UIFont.systemFont(ofSize: 21)
        result.textColor = .gray
        //result.frame.size = CGSize(width: 100, height: 50)
        result.translatesAutoresizingMaskIntoConstraints = false
        result.widthAnchor.constraint(equalToConstant: 200).isActive = true
        result.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        return result
    }()

    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        
        // Set stack view properties
        self.axis = .vertical
        self.spacing = 20
        self.alignment = .leading
        
        self.addArrangedSubview(timerLabel)
        self.addArrangedSubview(turnCounterLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    @objc
    func timerFired() {
        
        self.timeElapsed += 0.01
        self.timerLabel.text = String(format: "  Time: %.2f", timeElapsed)
    }
    
    // MARK: - Public Methods
    
    func incrementCounter() {
        
        self.counter += 1
        self.turnCounterLabel.text = "  Turns: \(counter)"
    }
}
