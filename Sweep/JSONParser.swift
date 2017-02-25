//
//  JSONParser.swift
//  Sweep
//
//  Created by Michael Smith on 2/24/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation


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
}
