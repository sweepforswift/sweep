//
//  Decodable.swift
//  Sweep
//
//  Created by Michael Smith on 3/26/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation

public protocol Decodable{
    /**
     Decoes the string representation of the item to its true representation
     - parameter value: The string to be converted
     - returns: An instance of the object cast to the proper type
     */
    static func decode(value: String) -> Decodable?
}

extension String: Decodable{
    public static func decode(value: String) -> Decodable? {
        return value
    }
}

extension Int: Decodable{
    public static func decode(value: String) -> Decodable? {
        return Int(value)
    }
}

extension Double: Decodable{
    public static func decode(value: String) -> Decodable? {
        return Double(value)
    }
}

extension Float: Decodable{
    public static func decode(value: String) -> Decodable? {
        return Float(value)
    }
}

extension Decimal: Decodable{
    public static func decode(value: String) -> Decodable? {
        return Decimal(Int(value)!)
    }
}

extension Bool: Decodable{
    public static func decode(value: String) -> Decodable? {
        switch value {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}
