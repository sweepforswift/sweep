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
    
    /**
     Creates a Core Data Fetch Request for the specified model
     - parameter model: The model to create the fetch request
     - returns: An NSFetchRequest for the specified entity
     */
    private func buildFetchRequest(model: String) -> NSFetchRequest<NSFetchRequestResult>{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    
        let entityDescription = NSEntityDescription.entity(forEntityName: model, in: CoreDataORM.managedContext!)
    
        fetchRequest.entity = entityDescription
        return fetchRequest
    }
    
    /**
     Creates a fetch request to get all of a specified entity from Core Data
     - parameter model: The model to create the fetch request
    */
    public func all(model: String){
        self.fetchRequest = self.buildFetchRequest(model: model)
    }
    
    /**
     Returns a specific Core Data entity based upon by a specific value for a specific key
     - parameter model: The model to create the fetch request
     - parameter byId: The value to look for
     - parameter forKey: The key to search
     - returns: An instance of the object being searched for
     */
    public func find<T>(model:String, byId: Any, forKey: String) -> T?{
        if self.fetchRequest == nil{
            self.fetchRequest = self.buildFetchRequest(model: model)
        }
        self.fetchRequest?.predicate = buildSinglePredicate(field: forKey, value: byId)
        return self.performSelect()?.first
    }
    
    /**
     Builds an NSPredicate for an equal to look up for the find method
     - parameter field: The field to search
     - parameter value: The value to search for
     - returns: An NSPredicate representing the search
     */
    private func buildSinglePredicate(field: String, value:Any) -> NSPredicate{
        let predicate = self.buildWhereClause(key: field, op: .equalTo, comparedTo: value) as! NSPredicate
        return predicate
    }
    
    /**
     Gets the data from Core Data based upon the previously constructed fetch request
     - returns: An array of the objects being selected from Core Data
     */
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
    
    /**
     Builds an NSComparisonPredicate to select based upon a where clause
     - parameter key: The field to match against
     - parameter op: The type of opertaion to perform
     - parameter comparedTo: The item to compare the values for the specified key by the specified operation
     - returns:
     */
    public func buildWhereClause(key: String, op: NSComparisonPredicate.Operator, comparedTo: Any) -> Any{
        let pred = NSComparisonPredicate(leftExpression: NSExpression(forKeyPath: "\(key)"), rightExpression: NSExpression(forConstantValue: comparedTo), modifier: .direct, type: op)
        fetchRequest?.predicate = pred
        return pred
    }
    
    /**
     Creates an Or Where clause by creating an NSCompoundPredicate from the previous predicate and the new one
     - parameter orWhere: The field to match against
     - parameter op: The type of opertaion to perform
     - parameter comparedTo: The item to compare the values for the specified key by the specified operation
     */
    public func find(orWhere: String, op: NSComparisonPredicate.Operator, comparedTo:Any){
        if fetchRequest?.predicate != nil{
            let oldPred = fetchRequest?.predicate
            let pred = NSComparisonPredicate(leftExpression: NSExpression(forKeyPath: "\(orWhere)"), rightExpression: NSExpression(forConstantValue: comparedTo), modifier: .direct, type: op)
            let compPred = NSCompoundPredicate(orPredicateWithSubpredicates: [oldPred!, pred])
            fetchRequest?.predicate = compPred
        }
    }
    
    /**
     Creates an And Where clause by creating an NSCompoundPredicate from the previous predicate and the new one
     - parameter andWhere: The field to match against
     - parameter op: The type of opertaion to perform
     - parameter comparedTo: The item to compare the values for the specified key by the specified operation
     */
    public func find(andWhere: String, op: NSComparisonPredicate.Operator, comparedTo: Any){
        if fetchRequest?.predicate != nil{
            let oldPred = fetchRequest?.predicate
            let pred = NSComparisonPredicate(leftExpression: NSExpression(forKeyPath: "\(andWhere)"), rightExpression: NSExpression(forConstantValue: comparedTo), modifier: .direct, type: op)
            let compPred = NSCompoundPredicate(andPredicateWithSubpredicates: [oldPred!, pred])
            fetchRequest?.predicate = compPred
        }
    }
    
    /**
     Orders the data by the specified key either asc or desc
     - parameter by: The key to sort by
     - parameter asc: Whether it is ascending or not
    */
    public func order(by: String, asc: Bool){
        if fetchRequest?.predicate != nil{
            let sortDescriptor = NSSortDescriptor(key: by, ascending: asc)
            if var sortDescriptors = fetchRequest?.sortDescriptors{
                sortDescriptors.append(sortDescriptor)
            }else{
                fetchRequest?.sortDescriptors = [sortDescriptor]
            }
        }
    }
}
