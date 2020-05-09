//
//  CountryStatCell.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import UIKit

class CountryStatCell: UITableViewCell {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var countryFlagImageView: UIImageView!
    
    override func fill(with item: Any)
    {
        if let data = item as? CountryStat
        {
            self.countryNameLabel.text = data.name
            self.recoveredLabel.text = "Recovered: \(data.recovered ?? 0)"
            self.deathsLabel.text = "Deaths: \(data.deaths ?? 0)"
            self.confirmedLabel.text = "Confirmed: \(data.confirmed ?? 0)"
            self.countryFlagImageView.image = data.flagImage
            self.countryFlagImageView.downloaded(from: APPURL.CountrFlagsUrl
                .replacingOccurrences(of: "{code}", with: data.code ?? "")
                .replacingOccurrences(of: "{size}", with: "64"))
        }
    }
}
