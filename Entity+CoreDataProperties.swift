//
//  Entity+CoreDataProperties.swift
//  WeatherCheck
//
//  Created by 박종화 on 10/20/23.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var city: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?

}

extension Entity : Identifiable {

}
