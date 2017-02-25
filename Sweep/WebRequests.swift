//
//  WebRequests.swift
//  Sweep
//
//  Created by Reiker Seiffe on 2/24/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation

public class WebRequests: NSObject{
    
    func getRequest(url:String) -> Request?{
        print("Got into the function")
        guard let url = URL(string: url) else {
            print("Couldnt cast URL string")
            return nil
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        let requestObject = Request(request: request)
        
        return requestObject
    }
}
