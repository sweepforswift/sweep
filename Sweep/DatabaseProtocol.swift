//
//  DatabaseProtocol.swift
//  Sweep
//
//  Created by Michael Smith on 3/17/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation

public enum OrderBy{
    case ASC
    case DESC
}

public protocol Database: class{
    static func all() -> QueryBuilder
    static func find<T>(key: String, value: Any) -> T?
    static func find(where: String, op: NSComparisonPredicate.Operator, comparedTo: Any) -> QueryBuilder
    //func find(orWhere: String, op: String, comparedTo: Any) -> QueryBuilder
    //func find(andWhere: String, op: String, comparedTo: Any) -> QueryBuilder
    static func orderBy(prop: String, order:OrderBy) -> QueryBuilder
    func save() -> Bool
    static var model: String {
        get
    }
}
