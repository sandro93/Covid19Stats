//
//  LoadingView.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if #available(iOS 11.0, *)
        {
            self.activityIndicator.color = UIColor.appColor(.indicatorColor)
        }
    }
    
    static func xibStance() -> LoadingView {
        return LoadingView.fromNib()
    }
    
}
