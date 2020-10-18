//
//  CoreDataSingleton.swift
//  Messenger
//
//  Created by Marcos Kilmer on 18/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CoreDataManager {
    
    static var shared = CoreDataManager()
    var selfContext:NSManagedObjectContext!
    
    func setupCoreDataSingleton(){
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let context = delegate?.persistentContainer.viewContext
        
        self.selfContext = context
       
    }
    
    func saveContext() {
        do {
            
            try self.selfContext.save()
            
        } catch let err {
            print(err)
        }
    }
    
    func loadData<T>(entityName:String, array:[T]?) -> [T] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var arrayOfModels:[T]!
        
        do {
            arrayOfModels = try (selfContext.fetch(fetchRequest)) as? [T]
            return arrayOfModels
            
        } catch let err {
            print(err)
            return arrayOfModels
        }
        
    }
    
    func clearData<T>(type:[T],entityName:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        

        do {
            let objects = try (selfContext.fetch(fetchRequest)) as? [T]

            objects?.forEach({ (element) in
                selfContext.delete(element as! NSManagedObject)
            })

             self.saveContext()

        } catch let err {
            print(err)

        }
        
    }
}
