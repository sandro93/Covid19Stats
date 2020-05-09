//
//  CDNavigationController.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/9/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import UIKit

class DefaultNavigationController: UINavigationController {
    
    static let shared = DefaultNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar()
    {
        self.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationBar.barTintColor = .systemPurple
        self.navigationBar.backgroundColor = .systemPurple
    }
}

