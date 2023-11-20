//
//  Entity+CoreDataProperties.swift
//  WeatherCheck
//
//  Created by 박종화 on 11/20/23.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var temp: String?
    @NSManaged public var time: String?
    @NSManaged public var city: String?
    @NSManaged public var lowhigh: String?

}

extension Entity : Identifiable {

}
