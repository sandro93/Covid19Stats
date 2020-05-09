//
//  UIViewControllerExtensions.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import UIKit

extension UIViewController
{
    func startLoading()
    {
        self.view.isUserInteractionEnabled = false
        self.view.alpha = 0.95
        let loader = AppDelegate.shared.loadingView
        loader.center = self.view.center //(AppDelegate.shared.window?.center)!
        self.view.addSubview(loader)
        self.view.bringSubviewToFront(loader)
        //loader.startAnimating()
    }
    
    func stopLoading()
    {
        self.view.isUserInteractionEnabled = true
        self.view.alpha = 1
        let loader = AppDelegate.shared.loadingView
        loader.removeFromSuperview()
    }
    
    func loadAsRootViewController(on window: UIWindow? = nil) -> Self?
    {
        var w : UIWindow?
        if(window == nil)
        {
            if let window = UIApplication.shared.delegate?.window
            {
                w = window
            }
        }
        w?.rootViewController = self
        w?.makeKeyAndVisible()
        return self
    }
    
    fileprivate static func _load<T>(with id: String, from storyboard: String, for bundle: Bundle? = nil) -> T?
    {
        return UIStoryboard(name: storyboard, bundle: bundle).instantiateViewController(withIdentifier: id) as? T
    }
    
    static func load(with id: String, from storyboard: String, for bundle: Bundle? = nil) -> Self?
    {
        return self._load(with: id, from: storyboard, for: bundle)
    }
    
    static func load(from storyboard: String, for bundle: Bundle? = nil) -> Self?
    {
        return self.load(with: self.className, from: storyboard, for: bundle)
    }
    
    public class func loadFromStoryboard() -> Self
    {
        return self.load(from: self.className.replacingOccurrences(of: "NavigationController", with: "").replacingOccurrences(of: "ViewController", with: "").replacingOccurrences(of: "Controller", with: ""))!
//        return self.load(from: self.className.replacingOccurrences(of: "ViewController", with: "").replacingOccurrences(of: "Controller", with: ""))!
    }
}
