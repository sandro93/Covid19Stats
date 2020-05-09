//
//  UrlConstants.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

struct APPURL {
    
    static let Domain  = "https://api.covid19api.com"
    static let CountrFlagsUrl = "https://www.countryflags.io/{code}/flat/{size}.png"
    
    static var CountryStatsAll: String {
        return Domain + Method.All
    }
    
    private struct Method {
        static let All = "/all"
    }
    
    static let headers: [String: String] = [Header.Key.Origin : Header.Value.OriginValue]
    
    private struct Header {
        struct Key {
            static let Origin = "Origin"
        }
        
        struct Value {
            static let OriginValue = "http://localhost"
        }
    }
}
