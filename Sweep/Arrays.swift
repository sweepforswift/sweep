//
//  Arrays.swift
//  Sweep
//
//  Created by Teodor Ivanov on 2/25/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation

public protocol Averagable: ExpressibleByIntegerLiteral {
    static func +(lhs: Self, rhs: Self) -> Self
}

extension Int: Averagable {}
extension Double: Averagable{}
extension Float: Averagable{}


public extension Sequence where Iterator.Element: Averagable {
    
    var sum: Iterator.Element {
        return reduce(0, +)
    }
    
    func average() -> Double
    {
        if(self.underestimatedCount == 0)
        {
            return 0.0
        }
        
        let doubleSum = self.sum as? Double
        if let doubleSum = doubleSum{
           return doubleSum / Double(self.underestimatedCount)
        }
        
        let intSum = self.sum as? Int
        if let intSum = intSum {
            return Double(intSum / self.underestimatedCount)
        }
        
        let floatSum = self.sum as? Float
        if let floatSum = floatSum {
            return Double(floatSum) / Double(self.underestimatedCount)
        }
        
        return 0.0
    }
}

public extension Sequence {
 /*
    func take(index: Int) -> [Iterator.Element]
    {
        if((index > self.underestimatedCount) && self.underestimatedCount == 0)
        {
            return []
        }
        self.split(whereSeparator: <#T##(Self.Iterator.Element) throws -> Bool#>)
        return self as! [Self.Iterator.Element]
    }
 */
}
