//
//  ConnectionProtocol.swift
//  Sweep
//
//  Created by Michael Smith on 3/22/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation

public protocol ConnectionProtocol: class{
     func all(model: String) -> Any
    
    //func find<T>(id: Any) -> T?
//    func find(where: String, op: String, comparedTo: Any) -> QueryBuilder
//    func find(orWhere: String, op:String, comparedTo: Any) -> QueryBuilder
//    func find(andWhere: String, op:String, comparedTo: Any) -> QueryBuilder
//    func orderBy(prop: String, order:OrderBy) -> QueryBuilder
//    func save() -> Bool
//    func get<T>() -> [T]?
//    func first<T>() -> T?
     func find<T>(model:String, byId: Any, forKey: String) -> T?
     func performSelect<T>(request: Any) -> [T]?
     func buildWhereClause(key: String, op: String, comparedTo: Any) -> Any
    static func build() -> Self
    
    init()
}
