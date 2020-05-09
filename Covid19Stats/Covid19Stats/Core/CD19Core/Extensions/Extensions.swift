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
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
