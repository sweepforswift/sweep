//
//  CoreDataExtensions.swift
//  Sweep
//
//  Created by Michael Smith on 3/17/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation
import CoreData

public protocol CoreDataDatabase: Database{}

extension NSManagedObject: Database {
    
    public class var model: String{
        get{
            return String(describing: type(of: self))
        }
    }
    
    /**
     Creates a Query Builder for selecting all of a specfic model
     - returns: A Query Builder instance with proper connection and select clause
     */
    public static func all() -> QueryBuilder {
        return QueryBuilder(model: self.model).all()
    }
    
    /**
     Builds a select clause to select a single model based upon some critera
     - parameter key: The field to match against
     - parameter value: The value to search for
     - returns: An instance of the model
     */
    public static func find<T>(key: String, value: Any) -> T? {
        let result: T? = QueryBuilder(model: self.model).find(key: key, value: value)
        return result
    }
    
    /**
     Constructs a where clause on the configured connection
     - parameter where: The field to match against
     - parameter op: The type of operation to perform
     - parameter comparedTo: The data to compare against
     - returns: An instance of Query Builder with the where clause set on the connection
     */
    public static func find(where: String, op: NSComparisonPredicate.Operator, comparedTo: Any) -> QueryBuilder {
        return QueryBuilder(model: self.model).find(where: `where`, op: op, comparedTo: comparedTo)
    }
    
    public func save() -> Bool {
        do {
            try CoreDataORM.managedContext?.save()
        } catch {
            print("It crashed")
            return false
        }
        return true
    }

}
