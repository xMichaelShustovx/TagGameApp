//
//  LaunchView.swift
//  TagGameApp
//
//  Created by Michael Shustov on 07.12.2021.
//

import Foundation
import UIKit


class LaunchView: UIView {
    
    // MARK: - Properties and variables
    
    typealias PushNavigationControllerHandler = () -> Void
    
    var pushHandler: PushNavigationControllerHandler
    
    lazy var startButton: UIButton = {
        
        let button = UIButton()
        
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.setTitleColor(.red, for: .highlighted)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.frame.size = CGSize(width: 200, height: 50)

        button.addAction(UIAction(handler: { _ in
            print("Button tapped")
            self.pushHandler()
        }), for: .touchUpInside)
        
        button.layer.shadowColor = UIColor.blue.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.9

        return button
    }()
    
    // MARK: - Initializers
    
    init(pushHandler: @escaping PushNavigationControllerHandler) {
        self.pushHandler = pushHandler
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 50)))
        
        self.customizeView()

        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func customizeView() {
        
        self.backgroundColor = .clear
    }
    
    private func setConstraints() {
        startButton.center = self.center
        self.addSubview(startButton)
        startButton.reportSuperviews()
        
        NSLayoutConstraint.activate([
        
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        
    }
}

// MARK: - Helpers

extension UIView {
    @objc
    func reportNoninteractiveSuperview() {
        if let sup = self.superview {
            if !sup.isUserInteractionEnabled {
                print(sup, "is disabled")
            } else {
                sup.reportNoninteractiveSuperview()
            }
        } else {
            print("no disabled superviews found")
        }
    }
}

extension UIView {
    func pinToSuperview(_ insets:NSDirectionalEdgeInsets = .zero) {
        guard let sup = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: sup.topAnchor, constant: insets.top).isActive = true
        self.trailingAnchor.constraint(equalTo: sup.trailingAnchor, constant: -insets.trailing).isActive = true
        self.leadingAnchor.constraint(equalTo: sup.leadingAnchor, constant: insets.leading).isActive = true
        self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -insets.bottom).isActive = true
    }
}

extension UIView {
    @objc func reportSuperviews(filtering:Bool = true) {
        var currentSuper : UIView? = self.superview
        print("reporting on \(self)\n")
        while let ancestor = currentSuper {
            let ok = ancestor.bounds.contains(ancestor.convert(self.frame, from: self.superview))
            let report = "it is \(ok ? "inside" : "OUTSIDE") \(ancestor)\n"
            if !filtering || !ok { print(report) }
            currentSuper = ancestor.superview
        }
    }
}
