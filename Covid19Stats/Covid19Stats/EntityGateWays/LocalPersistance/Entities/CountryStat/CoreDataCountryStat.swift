//
//  CoreDataCountryStat.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/7/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import Foundation

extension CoreDataCountryStat {
    var countryStat: CountryStat {
        
        return CountryStat(code: code,
                           name: name,
                           confirmed: confirmed?.toInt,
                           deaths: deaths?.toInt,
                           recovered: recovered?.toInt)
    }
    
    func populate(with countryStat: CountryStat) {
        name = countryStat.name
        code = countryStat.code
        confirmed = countryStat.confirmed?.toString
        deaths = countryStat.deaths?.toString
        recovered = countryStat.recovered?.toString
    }
    
}
