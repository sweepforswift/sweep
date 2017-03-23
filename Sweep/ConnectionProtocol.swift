//
//  ConnectionProtocol.swift
//  Sweep
//
//  Created by Michael Smith on 3/22/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation

protocol ConnectionProtocol{
    func all() -> QueryBuilder
    
    func find<T>(id: Any) -> T?
    func find(where: String, op: String, comparedTo: Any) -> QueryBuilder
    func find(orWhere: String, op:String, comparedTo: Any) -> QueryBuilder
    func find(andWhere: String, op:String, comparedTo: Any) -> QueryBuilder
    func orderBy(prop: String, order:OrderBy) -> QueryBuilder
    func save() -> Bool
    func get<T>() -> [T]?
    func first<T>() -> T?

}
