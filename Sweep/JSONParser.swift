//
//  JSONParser.swift
//  Sweep
//
//  Created by Michael Smith on 2/24/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation

public protocol JSONAble{
    /**
     Allows the object to be constructed via JSON
     - parameter json: A JSON dictionary for the object
    */
    init(json: [String:Any])
}

public extension JSONAble{
    /**
     Converts the JSONAble object into a properly formatted JSON string.
     - returns: A properly formatted JSON string representing the object.
    */
    public func toJSON() -> String{
        var jsonString = "{"
        let m = Mirror(reflecting: self)
        m.children.forEach{ (body) in
            if let s = body.value as? String{
                jsonString += "\"\(body.label!):\" \"\(s)\","
            }else if let i = body.value as? Int{
                jsonString += "\"\(body.label!):\" \(i),"
            }
            
        }
        let index = jsonString.index(jsonString.endIndex, offsetBy: -1)
        jsonString.remove(at: index)
        jsonString += "}"
        return jsonString
    }
}

public extension Sequence where Iterator.Element: JSONAble{
    /**
     Converts the array of JSONAble items into a proper JSON string
     - returns: A properly formatted JSON string representing the array of objects
    */
    public func toJSON() -> String{
        var jsonString = "["
        for item in self{
            jsonString += item.toJSON() + ","
        }
        let index = jsonString.index(jsonString.endIndex, offsetBy: -1)
        jsonString.remove(at: index)
        jsonString += "]"
        return jsonString
    }
}


public class JSONParser{
    /**
     Converts the given JSON string into either a Dictionary or Array
     - parameter jsonString: The JSON string to be converted
     - returns: Either a Dictionary or Array based upon the variable the return is assigned to
    */
    public static func parse<T>(jsonString: String) -> T?{
        let data = jsonString.data(using: .utf8)
        let json:T? = self.parse(jsonData: data!)
        
        guard let result = json as T? else{
            return nil
        }
        return result
    }
    
    /**
     Converts the given JSON data into either a Dictionary or Array
     - parameter jsonData: The JSON data to be converted
     - returns: Either a Dictionary or Array based upon the variable the return is assigned to
    */
    public static func parse<T>(jsonData: Data) -> T?{
        let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
        
        guard let result = json as? T else{
            return nil
        }
        return result
    }
    
    /**
     Converts the given JSON data into an array of classes based upon variable the return is assigned to.
     The class in the array must conform to the JSONAble protocol.
     - parameter jsonData: The JSON data to be converted
     - returns: An array of objects that conform to the JSONAble protocol
     */
    public static func parse<T>(toObject jsonData:Data) -> [T]? where T:JSONAble{
        let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
        
        if let result = json as? [String:Any]{
            return [T(json: result)]
        }
        
        if let result = json as? [[String:Any]]{
            var data: [T] = []
            for object in result{
                data.append(T(json: object))
            }
            return data
        }

        return nil
    }
    
    /**
     Converts the given JSON string into an array of classes based upon variable the return is assigned to.
     The class in the array must conform to the JSONAble protocol.
     - parameter jsonData: The JSON data to be converted
     - returns: An array of objects that conform to the JSONAble protocol
     */
    public static func parse<T>(toObject jsonString: String) -> [T]? where T:JSONAble{
        let data = jsonString.data(using: .utf8)
        return self.parse(toObject: data!)
    }
}
