//
//  CovidStatsConfigurator.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import Foundation
protocol CovidStatsConfigurator {
    func configure(covidStatsViewController : CovidStatsViewController)
}
class CovidStatsConfiguratorImplementation : CovidStatsConfigurator {
    
    func configure(covidStatsViewController : CovidStatsViewController) {
        
        let apiClient = ApiClientImplementation.init(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
        let apiCountryStatsGateWay = ApiCountryStatsGateWayImplementation.init(apiClient: apiClient)
        
        let viewContext = CoreDataStackImplementation.sharedInstance.persistentContainer.viewContext
        let localPersistantCountryStatsGateWay = CoreDataCountryStatGateWay.init(viewContext: viewContext)
        let cacheCountryStatsGateWay = CacheCountryStatGateWayImplementation.init(apiCountryStatGateWay: apiCountryStatsGateWay, localPersistantCountryStatsGateWay: localPersistantCountryStatsGateWay)
        
        let displayCountryStats = DisplayCountryStatsUseCaseImplementation.init(countryStatsGateWay:cacheCountryStatsGateWay)
        
        let presenter = CovidStatsPresenterImplementation.init(view: covidStatsViewController, displayCountryStatsUseCase: displayCountryStats)
        
        covidStatsViewController.presenter = presenter
    }
}
