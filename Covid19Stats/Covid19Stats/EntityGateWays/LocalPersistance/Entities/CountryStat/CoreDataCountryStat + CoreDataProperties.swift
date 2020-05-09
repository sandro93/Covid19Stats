//
//  CoreDataჩოუნტრყშტატ + CoreDataProperties.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/7/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import Foundation
import CoreData


extension CoreDataCountryStat {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataCountryStat> {
        return NSFetchRequest<CoreDataCountryStat>(entityName: "CoreDataCountryStat");
    }
    
    @NSManaged public var name: String?
    @NSManaged public var confirmed: String?
    @NSManaged public var deaths: String?
    @NSManaged public var recovered: String?
    @NSManaged public var code: String?
    
}

