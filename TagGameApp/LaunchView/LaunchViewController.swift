//
//  LaunchViewController.swift
//  TagGameApp
//
//  Created by Michael Shustov on 07.12.2021.
//

import UIKit

class LaunchViewController: UIViewController {
    
    // MARK: - Properties and variables
    
    let gameVC = GameViewController()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        // Add Launch View
        let launchView = LaunchView(pushHandler: self.handlePushNavigationControllerButton)
        launchView.center = self.view.center
        self.view.addSubview(launchView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title and background
        self.title = "Tag Game"
        self.view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    // MARK: - Private Methods
    
    func handlePushNavigationControllerButton() {
        
        if let navController = self.navigationController {
            
            // Present Game VC as second screen of navigation view
            navController.pushViewController(self.gameVC, animated: true)
        }
    }
}
