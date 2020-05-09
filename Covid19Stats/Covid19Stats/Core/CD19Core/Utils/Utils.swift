//
//  Utils.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/9/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case InternetConnectionOffline

    var localizedDescription: String { return "Internet connection lost!" }
}

@available(iOS 11.0, *)
enum AssetsColor {
   case indicatorColor
}

@available(iOS 11.0, *)
extension UIColor {

    static func appColor(_ name: AssetsColor) -> UIColor? {
        switch name {
        case .indicatorColor:
            return UIColor(named: "ActivityIndicatorColor")
        }
    }
}
