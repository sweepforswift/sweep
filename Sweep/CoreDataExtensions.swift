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
    
    private var model: String{
        get{
            return String(describing: type(of: self))
        }
    }
    
    public func all() -> QueryBuilder {
        return QueryBuilder(model: self.model).all()
    }
    
    public func find<T>(id: Any) -> T? {
        return QueryBuilder(model: self.model).find(id: id)
    }
    
    public func find(where: String, op: String, comparedTo: Any) -> QueryBuilder {
        return QueryBuilder(model: self.model).find(where: `where`, op: op, comparedTo: comparedTo)
    }
    
    public func orderBy(prop: String, order:OrderBy) -> QueryBuilder {
        return QueryBuilder(model: self.model).orderBy(prop: prop, order: order)
    }
    
    public func save() -> Bool {
        return true
    }

}
