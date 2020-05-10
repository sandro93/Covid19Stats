//
//  UIExtensions.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/7/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import Foundation
import UIKit

public extension Int {
    
    var toString : String { get { return "\(self)" } }
    
}

public extension String {
    
    var toInt : Int { get { let number = NSDecimalNumber(string: self); return number == NSDecimalNumber.notANumber ? 0 : number.intValue } }
    
}

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}

public extension NSObject {
    
    static var stringFromClass : String { return NSStringFromClass(self) }
    
    var stringFromClass : String { return NSStringFromClass(type(of: self)) }
    
    static var className : String { return self.stringFromClass.components(separatedBy: ".").last! }
    
    var className : String { return self.stringFromClass.components(separatedBy: ".").last! }
    
}

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
}

extension UITableViewCell: Reusable {
    
    @objc func fill(with item: Any)
    {
        
    }
    
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIImageView {
    
    func setImage(from urlString: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: urlString) else { return }
        
        ImageCache.shared.imageFor(url: url) { [weak self] (result, error) in
            
            if let result = result {
                DispatchQueue.main.async() {
                    self?.image = result
                }
            }
            
            if error != nil {
                DispatchQueue.main.async() {
                    self?.image = placeholder
                }
            }
        }
    }
}
