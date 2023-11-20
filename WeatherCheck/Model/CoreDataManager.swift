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
    
    func createEntity(city: String, time: String, temp: String, lowhigh: String) {
        let newEntity = Entity(context: context)
        newEntity.city = city
        newEntity.time = time
        newEntity.temp = temp
        newEntity.lowhigh = lowhigh
        
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
    
    func updateEntity(entity: Entity, city: String, time: String, temp: String, lowhigh: String) {
        entity.city = city
        entity.time = time
        entity.temp = temp
        entity.lowhigh = lowhigh
        
        saveToContext()
    }
    
    func deleteEntity(entity: Entity) {
        context.delete(entity)
        
        saveToContext()
    }
}

