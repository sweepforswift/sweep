//
//  WebRequests.swift
//  Sweep
//
//  Created by Reiker Seiffe on 2/24/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation


/**
    Constructs various types of Request class instances and return the instance with the correct HTTP method and body set
 */
public class WebRequests: NSObject{
    
    
    /**
     Builds an instance of Request and sets the HTTP method to type "GET"
     
     - parameter:  URL of get request as type String
     
     - return: Instance of the Request class set to type GET
 
    */
    
    func getRequest(url:String) -> Request?{
        guard let url = URL(string: url) else {
            print("Couldnt cast URL string")
            return nil
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        let requestObject = Request(request: request)
        return requestObject
    }
    
    /**
     Builds an instance of Request and sets the HTTP method to type "POST" and HTTP body to input
     
     - parameter: URL of post request as type String
     - parameter: String of data to be passed through in the method Body as type String
     
     - return: Instance of the Request class set to type POST with the post body set to the
     
     */
    
    func postRequest(url:String, postString:String) -> Request?{
        guard let url = URL(string: url) else{
            print("Couldnt cast URL string")
            return nil
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        
        let requestObject = Request(request:request)
        return requestObject
        
    }
    
    /**
     Builds an instance of Request and sets the HTTP method to type "DELETE"
     
     - parameter: Delete request URL as type String
     
     - return: Instance of the Request class set to type Delete
     
     */
    
    func deleteRequest(url:String) -> Request?{
        guard let url = URL(string: url) else{
            print("Couldnt cast URL string")
            return nil
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "DELETE"
        
        let requestObject = Request(request:request)
        return requestObject
        
    }
    
    /**
     Builds an instance of Request and sets the HTTP method to type "PUT"
     
     - parameter: get request URL as type String
     
     - return: Instance of the Request class set to type GET
     
     */
    
    func putRequest(url:String) -> Request?{
        guard let url = URL(string: url) else{
            print("Couldnt cast URL string")
            return nil
        }
        var request = URLRequest(url:url)
        request.httpMethod = "PUT"
        
        let requestObject = Request(request:request)
        return requestObject
    }
    
}
