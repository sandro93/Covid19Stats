//
//  ApiCountryStat.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import Foundation
struct ApiCountryStats: InitializableWithJson {
    
    var name: String?
    var code: String?
    var deaths: Int?
    var recovered: Int?
    var confirmed:Int?
    
    init(json: [String : Any]) throws {
        
        guard let name = json["Country"] as? String,
            let code = json["CountryCode"] as? String,
            let confirmed = json["Confirmed"] as? Int,
            let deaths = json["Deaths"] as? Int,
            let recovered = json["Recovered"] as? Int
            
            else {
                throw NSError.createPraseError()
        }
        
        self.name = name
        self.code = code
        self.confirmed = confirmed
        self.deaths = deaths
        self.recovered = recovered
    }
}

extension ApiCountryStats {
    var countryStats: CountryStat {
        return CountryStat(code: code,
                           name: name,
                           confirmed: confirmed,
                           deaths: deaths,
                           recovered: recovered)
        
    }
}

