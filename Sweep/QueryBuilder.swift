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
    
    /**
     Creates an instance of the Query Builder for a specific model
     - parameter model: The model currently being used
     */
    init(model: String){
        self.model = model
    }
    
    /**
     Creates a Query Builder for selecting all of a specfic model
     - returns: A Query Builder instance with proper connection and select clause
     */
    public func all() -> QueryBuilder {
        let databaseConnector = QueryBuilder.connection?.build()
        let _ = databaseConnector?.all(model: self.model)
        self.currentConnection = databaseConnector
        return self
    }
    
    /**
     Builds a select clause to select a single model based upon some critera
     - parameter key: The field to match against
     - parameter value: The value to search for
     - returns: An instance of the model
     */
    public func find<T>(key: String, value: Any) -> T? {
        let databaseConnector = QueryBuilder.connection?.build()
        let result: T? = databaseConnector?.find(model: self.model, byId: value, forKey: key)
        return result
    }
    
    /**
     Constructs a where clause on the configured connection
     - parameter where: The field to match against
     - parameter op: The type of operation to perform
     - parameter comparedTo: The data to compare against
     - returns: An instance of Query Builder with the where clause set on the connection
     */
    public func find(where: String, op: NSComparisonPredicate.Operator, comparedTo: Any) -> QueryBuilder {
        let _ = self.currentConnection?.buildWhereClause(key: `where`, op: op, comparedTo: comparedTo)
        return self
    }
    
    /**
     Constructs an or where clause on the configured connection
     - parameter orWhere: The field to match against
     - parameter op: The type of operation to perform
     - parameter comparedTo: The data to compare against
     - returns: An instance of Query Builder with the or where clause set on the connection
     */
    public func find(orWhere: String, op: NSComparisonPredicate.Operator, comparedTo: Any) -> QueryBuilder{
        self.currentConnection?.find(orWhere: orWhere, op: op, comparedTo: comparedTo)
        return self
    }
    
    /**
     Constructs an and where clause on the configured connection
     - parameter andWhere: The field to match against
     - parameter op: The type of operation to perform
     - parameter comparedTo: The data to compare against
     - returns: An instance of Query Builder with the and where clause set on the connection
     */
    public func find(andWhere: String, op: NSComparisonPredicate.Operator, comparedTo: Any) -> QueryBuilder{
        self.currentConnection?.find(andWhere: andWhere, op: op, comparedTo: comparedTo)
        return self
    }
    
    /**
     Constructs an Order by clause on the configured connection
     - parameter prop: The property to sort by
     - parameter order: Whether or not the is ascending
     - returns: An instance of Query Builder with the order by clause set on the connection
     */
    public func orderBy(prop: String, order: Bool) -> QueryBuilder {
        self.currentConnection?.order(by: prop, asc: order)
        return self
    }
    
    /**
     Fetches the models for the configured connection and fetch request from the database
     - returns: An array of the models being selected
     */
    public func get<T>() -> [T]?{
        return self.currentConnection?.performSelect()
    }
    
    /**
     Fetches the first model for the configured connection
     - returns: The first model from the returned array of models
     */
    public func first<T>() -> T? {
        return self.all().first()
    }
}
