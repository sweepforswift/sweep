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
    
    public static func all() -> QueryBuilder {
        return QueryBuilder(model: self.model).all()
    }
    
    public static func find<T>(key: String, value: Any) -> T? {
        let result: T? = QueryBuilder(model: self.model).find(key: key, value: value)
        return result
    }
    
    public static func find(where: String, op: NSComparisonPredicate.Operator, comparedTo: Any) -> QueryBuilder {
        return QueryBuilder(model: self.model).find(where: `where`, op: op, comparedTo: comparedTo)
    }
    
    public static func orderBy(prop: String, order:OrderBy) -> QueryBuilder {
        return QueryBuilder(model: self.model).orderBy(prop: prop, order: order)
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
