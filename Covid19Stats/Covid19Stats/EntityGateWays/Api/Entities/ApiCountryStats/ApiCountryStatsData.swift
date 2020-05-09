//
//  ApiCountryStatsData.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import Foundation

struct ApiCountryStatsData: InitializableWithData, InitializableWithJsonArray {
    
    var data: [ApiCountryStats]
    
    //    init(data: Data?) throws {
    //        guard let data = data,
    //            let jsonObject = try? JSONSerialization.jsonObject(with: data),
    //            let json = jsonObject as? [String:Any] else {
    //                throw NSError.createPraseError()
    //        }
    //
    //        try self.init(json: json)
    //    }
    
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let jsonArray = jsonObject as? [[String:Any]] else {
                throw NSError.createPraseError()
        }
        
        try self.init(jsonArray: jsonArray)
    }
    
    init(jsonArray: [[String : Any]]) throws {
        var data: [ApiCountryStats] = []
        for item in jsonArray {
            data.append(try ApiCountryStats.init(json: item))
        }
        self.data = data
    }
    
}
