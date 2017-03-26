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
    private var fetchRequest: NSFetchRequest<NSFetchRequestResult>?
    
    
    public static func build() -> Self{
        return self.init()
    }
    
    required public init(){
        
    }
    
    private func buildFetchRequest(model: String) -> NSFetchRequest<NSFetchRequestResult>{
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: model, in: CoreDataORM.managedContext!)
    
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        return fetchRequest
    }
    
    public func all(model: String){
        
        self.fetchRequest = self.buildFetchRequest(model: model)
    }
    
    public func find<T>(model:String, byId: Any, forKey: String) -> T?{
        if self.fetchRequest == nil{
            self.fetchRequest = self.buildFetchRequest(model: model)
        }
        self.fetchRequest?.predicate = buildSinglePredicate(field: forKey, value: byId)
        return self.performSelect()?.first
    }
    
    private func buildSinglePredicate(field: String, value:Any) -> NSPredicate{
        let predicate = self.buildWhereClause(key: field, op: .equalTo, comparedTo: value) as! NSPredicate
        return predicate
    }
    
    public func performSelect<T>() -> [T]?{
        do {
            let result = try CoreDataORM.managedContext?.fetch(self.fetchRequest!) as! [T]?
            return result
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return nil
    }
    
    public func buildWhereClause(key: String, op: NSComparisonPredicate.Operator, comparedTo: Any) -> Any{
        let pred = NSComparisonPredicate(leftExpression: NSExpression(forKeyPath: "\(key)"), rightExpression: NSExpression(forConstantValue: comparedTo), modifier: .direct, type: op)
        fetchRequest?.predicate = pred
        return pred
    }
}
