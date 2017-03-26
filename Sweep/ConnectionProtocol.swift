//
//  ConnectionProtocol.swift
//  Sweep
//
//  Created by Michael Smith on 3/22/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation

public protocol ConnectionProtocol: class{
    /**
     Creates a fetch request to get all of a specified entity from the database
     - parameter model: The model to create the fetch request
     */
    func all(model: String)
    
    /**
     Returns a specific Core Data entity based upon by a specific value for a specific key
     - parameter model: The model to create the fetch request
     - parameter byId: The value to look for
     - parameter forKey: The key to search
     - returns: An instance of the object being searched for
     */
    func find<T>(model:String, byId: Any, forKey: String) -> T?
    
    /**
     Gets the data from the database based upon the previously constructed fetch request
     - returns: An array of the objects being selected from Core Data
     */
    func performSelect<T>() -> [T]?
    
    /**
     Builds a whereClause to select based upon a where clause
     - parameter key: The field to match against
     - parameter op: The type of opertaion to perform
     - parameter comparedTo: The item to compare the values for the specified key by the specified operation
     - returns:
     */
    func buildWhereClause(key: String, op: NSComparisonPredicate.Operator, comparedTo: Any) -> Any
    
    /**
     Creates an Or Where clause by creating an NSCompoundPredicate from the previous predicate and the new one
     - parameter orWhere: The field to match against
     - parameter op: The type of opertaion to perform
     - parameter comparedTo: The item to compare the values for the specified key by the specified operation
     */
    func find(orWhere: String, op: NSComparisonPredicate.Operator, comparedTo:Any)
    
    /**
     Creates an And Where clause by creating an NSCompoundPredicate from the previous predicate and the new one
     - parameter andWhere: The field to match against
     - parameter op: The type of opertaion to perform
     - parameter comparedTo: The item to compare the values for the specified key by the specified operation
     */
    func find(andWhere: String, op: NSComparisonPredicate.Operator, comparedTo: Any)
    
    /**
     Orders the data by the specified key either asc or desc
     - parameter by: The key to sort by
     - parameter asc: Whether it is ascending or not
     */
    func order(by: String, asc: Bool)
    static func build() -> Self
    init()
}
