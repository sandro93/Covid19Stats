//
//  ApiCountryStatsRequest.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import Foundation

struct ApiCountryStatsRequest: ApiRequest {
    var urlRequest: URLRequest {
        let url: URL! = URL(string: APPURL.CountryStatsAll)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = APPURL.headers
        request.httpMethod = "GET"
        return request
    }
}
