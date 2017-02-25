//
//  JSONParser.swift
//  Sweep
//
//  Created by Michael Smith on 2/24/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation

public protocol JSONAble{
    init(json: [String:Any])
}

public extension JSONAble{
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
    public static func parse<T>(jsonString: String) -> T?{
        let data = jsonString.data(using: .utf8)
        let json = try? JSONSerialization.jsonObject(with: data!, options: [])
        
        guard let result = json as? T else{
            print("It failed")
            return nil
        }
        return result
    }
    
    public static func parse<T>(toObject jsonString: String) -> [T]? where T:JSONAble{
        let data = jsonString.data(using: .utf8)
        let json = try? JSONSerialization.jsonObject(with: data!, options: [])
        
        if let result = json as? [String:Any]{
            
            return [T(json: result)]
        }
        
        if let result = json as? [[String:Any]]{
            print("In second thing")
            var data: [T] = []
            for object in result{
                data.append(T(json: object))
            }
            return data
        }
        
        return nil
    }
}
