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
    
    
    public static func build() -> Self{
        return self.init()
    }
    
    required public init(){
        
    }
    
    public func all(model: String) -> Any{
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: model, in: CoreDataORM.managedContext!)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        return fetchRequest
    }
    
    public func find<T>(model:String, byId: Any, forKey: String) -> T?{
        let request = self.all(model: model) as! NSFetchRequest<NSFetchRequestResult>
        request.predicate = buildSinglePredicate(field: forKey, value: byId)
        return self.performSelect(request: request)?.first
    }
    
    private func buildSinglePredicate(field: String, value:Any) -> NSPredicate{
        let predicate = self.buildWhereClause(key: field, op: "==", comparedTo: value) as! NSPredicate
        return predicate
    }
    
    public func performSelect<T>(request: Any) -> [T]?{
        do {
            let result = try CoreDataORM.managedContext?.fetch(request as! NSFetchRequest)
            return result as! [T]?
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return nil
    }
    
    public func buildWhereClause(key: String, op: String, comparedTo: Any) -> Any{
        let predicate = NSPredicate(format: "\(key) \(op) %@", argumentArray: [comparedTo])
        return predicate
    }
}
