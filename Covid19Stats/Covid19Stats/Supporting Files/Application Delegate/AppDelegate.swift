//
//  AppDelegate.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/7/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var loadingView:LoadingView = {
        
        let loader = LoadingView.xibStance()
        return loader
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navController = DefaultNavigationController.shared.loadAsRootViewController()
        
        navController?.pushViewController(CovidStatsViewController.loadFromStoryboard(), animated: true)
        
        self.window?.rootViewController = navController
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
}

