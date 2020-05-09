//
//  CountryStatsGateWay.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/7/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import Foundation
typealias FetchCountryStatsGateWayCompletionHandler = (_ countryStats: Result<[CountryStat]>) -> Void

protocol CountryStatsGateWay {
    func fetchCountryStats(forceDownload: Bool?, completionHandler: @escaping FetchCountryStatsGateWayCompletionHandler)
}
