//
//  LocalPersistantCountryStatGateWay.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import Foundation
import CoreData

protocol LocalPersistantCountryStatGateWay: CountryStatsGateWay {
    func save(countryStats: [CountryStat])
}

class CoreDataCountryStatGateWay: LocalPersistantCountryStatGateWay {
    
    let viewContext: NSManagedObjectContextProtocol
    init(viewContext: NSManagedObjectContextProtocol) {
        self.viewContext = viewContext
    }
    
    func fetchCountryStats(forceDownload: Bool?, completionHandler: @escaping (Result<[CountryStat]>) -> Void) {
        if let coreDataCountryStats = try? viewContext.allEntities(withType: CoreDataCountryStat.self) {
            let countryStats = coreDataCountryStats.map { $0.countryStat }.sorted{ $0.name! < $1.name! }
            countryStats.count > 0 ? completionHandler(.success(countryStats)) : completionHandler(.failure(CoreError(message: "No Entities Found In Databse. Check Internet Connection.")))
                //completionHandler(.success(countryStats))
        }else{
            completionHandler(.failure(CoreError(message: "Failed retrieving Product the data base")))
        }
    }
}

extension CoreDataCountryStatGateWay {
    
    func save(countryStats: [CountryStat]) {
        
        let coreDataCountryStats = try? viewContext.allEntities(withType: CoreDataCountryStat.self)
        
        for item in countryStats {
            if let existingItem = coreDataCountryStats?.first(where: { $0.code == item.code }) {
                self.update(old: existingItem, with: item)
            } else {
                self.add(item: item)
            }
            
        }
    }
    
    fileprivate func add(item: CountryStat) {
        guard let coreDataCountryStat = viewContext.addEntity(withType: CoreDataCountryStat.self) else {
            return
        }
        coreDataCountryStat.populate(with: item)
        
        do {
            try viewContext.save() }
        catch {
            viewContext.delete(coreDataCountryStat)
        }
    }
    
    fileprivate func update(old: CoreDataCountryStat, with new: CountryStat)
    {
        old.populate(with: new)
        
        do {
            try viewContext.save()
        } catch {
            viewContext.delete(old)
        }
    }
}

