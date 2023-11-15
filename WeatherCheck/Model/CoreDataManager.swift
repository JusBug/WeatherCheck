//
//  CoreDataManager.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/20/23.
//

import Foundation
import UIKit

final class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entities: [Entity] = []
    
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createEntity(city: String, latitude: String, longitude: String) {
        let newEntity = Entity(context: context)
        newEntity.city = city
        newEntity.latitude = latitude
        newEntity.longitude = longitude
        
        saveToContext()
        getAllEntity()
    }
    
    func getAllEntity() {
        do {
            entities = try context.fetch(Entity.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateEntity(entity: Entity, city: String, latitude: String, longitude: String) {
        entity.city = city
        entity.latitude = latitude
        entity.longitude = longitude
        
        saveToContext()
    }
    
    func deleteEntity(entity: Entity) {
        context.delete(entity)
        
        saveToContext()
    }
}

