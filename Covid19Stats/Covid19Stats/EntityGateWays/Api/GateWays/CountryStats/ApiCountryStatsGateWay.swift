//
//  ApiCountryStatsGateWay.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import Foundation
protocol ApiCountryStatsGateWay: CountryStatsGateWay {
    
}

class ApiCountryStatsGateWayImplementation: ApiCountryStatsGateWay {
    
    let apiClient: ApiClient
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchCountryStats(forceDownload: Bool?, completionHandler: @escaping (Result<[CountryStat]>) -> Void) {
        let countryStatsRequest = ApiCountryStatsRequest()
        
        print(countryStatsRequest.urlRequest)
        self.apiClient.execute(request: countryStatsRequest) { (_ result: Result<ApiResponse<ApiCountryStatsData>>) in
            switch result {
            case let .success(response):
                let countryStatsAll = response.entity.data.map { $0.countryStats }
                
                let countryStatsAllGrouped = Dictionary(grouping: countryStatsAll, by: { $0.code }).compactMap{ item in
                    
                    return CountryStat(code: item.key,
                                       name: item.value.first!.name,
                                       confirmed: item.value.map({$0.confirmed ?? 0}).sum(),
                                       deaths: item.value.map({$0.deaths ?? 0}).sum(),
                                       recovered: item.value.map({$0.recovered ?? 0}).sum())
                } as [CountryStat]
                
                completionHandler(.success(countryStatsAllGrouped.sorted{ $0.name! < $1.name! }))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}


