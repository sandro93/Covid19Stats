//
//  DisplayCountryStats.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/7/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import Foundation

typealias DisplayCountryStatsUseCaseCompletionHandler = (_ products: Result<[CountryStat]>) -> Void

protocol DisplayCountryStatsUseCase {
    func fetchCountryStats(forceDownload: Bool?, completionHandler: @escaping DisplayCountryStatsUseCaseCompletionHandler)
}

class DisplayCountryStatsUseCaseImplementation: DisplayCountryStatsUseCase {
    
    let countryStatsGateWay: CountryStatsGateWay
    init(countryStatsGateWay: CountryStatsGateWay) {
        self.countryStatsGateWay = countryStatsGateWay
    }

    func fetchCountryStats(forceDownload: Bool?, completionHandler: @escaping DisplayCountryStatsUseCaseCompletionHandler) {
        self.countryStatsGateWay.fetchCountryStats(forceDownload: forceDownload) { (result) in
            print(result)
            completionHandler(result)
        }
    }
}
