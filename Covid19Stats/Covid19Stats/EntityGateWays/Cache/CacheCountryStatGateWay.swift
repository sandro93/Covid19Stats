//
//  CacheCountryStatGateWay.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//


import Foundation

class CacheCountryStatGateWayImplementation: CountryStatsGateWay {
    
    let apiCountryStatGateWay: ApiCountryStatsGateWay
    let localPersistantCountryStatsGateWay: LocalPersistantCountryStatGateWay
    
    init(apiCountryStatGateWay: ApiCountryStatsGateWay, localPersistantCountryStatsGateWay: LocalPersistantCountryStatGateWay) {
        self.apiCountryStatGateWay = apiCountryStatGateWay
        self.localPersistantCountryStatsGateWay = localPersistantCountryStatsGateWay
    }
    
    func fetchCountryStats(forceDownload: Bool?, completionHandler: @escaping (Result<[CountryStat]>) -> Void)
    {
        if Reachability.isConnectedToNetwork() {
            
            if forceDownload ?? false {
                self.apiCountryStatGateWay.fetchCountryStats(forceDownload: nil, completionHandler: { (result) in self.handleFetchCountryStatApiResult(result, completionHandler: completionHandler)
                })
            } else {
                self.localPersistantCountryStatsGateWay.fetchCountryStats(forceDownload: nil) { (result) in
                    switch result {
                    case let .success(countryStats):
                        completionHandler(.success(countryStats))
                        
                    case .failure(_):
                        self.apiCountryStatGateWay.fetchCountryStats(forceDownload: nil, completionHandler: { (result) in self.handleFetchCountryStatApiResult(result, completionHandler: completionHandler)
                        })
                    }
                }
            }
        } else {
            if forceDownload ?? false {
                completionHandler(.failure(NetworkError.internetConnectionOffline))
                return
            }
                
            self.localPersistantCountryStatsGateWay.fetchCountryStats(forceDownload: nil) { (result) in
                switch result {
                case let .success(countryStats):
                    completionHandler(.success(countryStats))
                    
                case .failure(_):
                    completionHandler(.failure(NetworkError.internetConnectionOffline))
                    
                }
            }
        }
    }
    
    fileprivate func handleFetchCountryStatApiResult(_ result: Result<[CountryStat]>, completionHandler: @escaping (Result<[CountryStat]>) -> Void) {
        switch result {
        case let .success(countryStats):
            localPersistantCountryStatsGateWay.save(countryStats: countryStats)
            completionHandler(result)
        case .failure(_):
            localPersistantCountryStatsGateWay.fetchCountryStats(forceDownload: nil,completionHandler: completionHandler)
            break
        } 
    }
}

