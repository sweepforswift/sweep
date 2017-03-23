//
//  CoreDataORM.swift
//  Sweep
//
//  Created by Michael Smith on 3/17/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataORM: ConnectionProtocol{
    public static var managedContext: NSManagedObjectContext?
    
    public static func all(model: String) -> Any{
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: model, in: CoreDataORM.managedContext!)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        return fetchRequest
        
//        do {
//            let result = try CoreDataORM.managedContext?.fetch(fetchRequest) as? [T]
//            return result
//            
//        } catch {
//            let fetchError = error as NSError
//            print(fetchError)
//        }
//        return nil
    }
    
    public static func find(model:String, byId: Any) -> NSFetchRequest<NSFetchRequestResult>{
        return self.all(model: model) as! NSFetchRequest<NSFetchRequestResult>
    }
}
