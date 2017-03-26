//
//  QueryBuilder.swift
//  Sweep
//
//  Created by Michael Smith on 3/17/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation
import CoreData

public class QueryBuilder{
    
    private var model: String
    
    private var fetchRequest: Any?
    private var fetchRequests: [Any] = []
    private var sort: [Any] = []
    public static var connection: ConnectionProtocol.Type?
    private var currentConnection: ConnectionProtocol?
    
    init(model: String){
        self.model = model
    }
    
    public func all() -> QueryBuilder {
        let databaseConnector = QueryBuilder.connection?.build()
        let _ = databaseConnector?.all(model: self.model)
        //self.fetchRequest = fetchRequest
        self.currentConnection = databaseConnector
        return self
    }
    
    public func find<T>(key: String, value: Any) -> T? {
        let databaseConnector = QueryBuilder.connection?.build()
        let result: T? = databaseConnector?.find(model: self.model, byId: value, forKey: key)
        return result
    }
    
    public func find(where: String, op: NSComparisonPredicate.Operator, comparedTo: Any) -> QueryBuilder {
        let _ = self.currentConnection?.buildWhereClause(key: `where`, op: op, comparedTo: comparedTo)
        return self
    }
    
    public func find(orWhere: String, op:String, comparedTo: Any) -> QueryBuilder{
        let fetchRequest = self.fetchRequest as? NSFetchRequest<NSFetchRequestResult>
        guard let initialPredicate = fetchRequest?.predicate else{
            return self
        }
        let addedPredicate = NSPredicate(format: "\(orWhere) \(op) %@", [comparedTo])
        let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [initialPredicate, addedPredicate])
        fetchRequest?.predicate = compoundPredicate
        self.fetchRequest = fetchRequest
        return self
    }
    
    public func find(andWhere: String, op:String, comparedTo: Any) -> QueryBuilder{
        let fetchRequest = self.fetchRequest as? NSFetchRequest<NSFetchRequestResult>
        guard let initialPredicate = fetchRequest?.predicate else{
            return self
        }
        let addedPredicate = NSPredicate(format: "\(andWhere) \(op) %@", [comparedTo])
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [initialPredicate, addedPredicate])
        fetchRequest?.predicate = compoundPredicate
        self.fetchRequest = fetchRequest
        return self
    }
    
    public func orderBy(prop: String, order:OrderBy) -> QueryBuilder {
        let fetchRequest = self.fetchRequest as? NSFetchRequest<NSFetchRequestResult>
        var asc = true
        if order == .ASC{
            asc = true
        }else if order == .DESC{
            asc = false
        }
        let sortDescriptor = NSSortDescriptor(key: prop, ascending: asc)
        if (fetchRequest?.sortDescriptors?.isEmpty)!{
            fetchRequest?.sortDescriptors = [sortDescriptor]
        }else{
            fetchRequest?.sortDescriptors?.append(sortDescriptor)
        }
        return self
    }
    
    public func save() -> Bool {
        return true
    }
    
    public func get<T>() -> [T]?{
        return self.currentConnection?.performSelect()
    }
    
    public func first<T>() -> T? {
        return self.all().first()
    }
}
