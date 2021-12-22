//
//  WinViewController.swift
//  TagGameApp
//
//  Created by Michael Shustov on 16.12.2021.
//

import UIKit

class WinViewController: UIViewController {

    // MARK: - Properties and variables
    
    lazy var winView = WinView(handler: closeHandler)
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        self.view = winView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    func closeHandler() {
        
        
    }
}
