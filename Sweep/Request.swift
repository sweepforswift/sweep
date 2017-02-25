//
//  Request.swift
//  Sweep
//
//  Created by Reiker Seiffe on 2/25/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import UIKit
import Foundation

class Request {
    var request:URLRequest?
    
    init(request:URLRequest?) {
        print("Request -> init")
        self.request = request
        
        if (self.request == nil){
            return
        }
    }
    
    public func runRequest(completion:@escaping(Data?, URLResponse?, Error?) -> Void){
        
        guard let request = request else{
            print("Request was nil")
            return
        }
        
        let session = URLSession.shared
        
        print("About the run the request")
        session.dataTask(with: request){
            (data, response, err) in
            print("Running the request")
            print("Session data: \(data)")
            print("Session response: \(response)")
            print("Session err: \(err)")
            completion(data, response, err)
        }.resume()
    }
    
    public func toJSON(completion:@escaping(Any?,Error?, Status) -> Void){
        runRequest(){
            (data:Data?,response:URLResponse?, err:Error?) in
            
            guard (response as! HTTPURLResponse?) != nil else {
                print("Couldnt cast response as HTTPURLRESPONSE")
                completion(response, err, Status.badRequest)
                return
            }
            
            if let response = response as! HTTPURLResponse?{
                if(response.statusCode == 404){
                    completion(response, err, Status.badRequest)
                    return
                }
            }
            
            print("Parsing the JSON")
            if let json = try? JSONSerialization.jsonObject(with: data!){
                completion(json, err, Status.success)
            }else{
                print("couldnt parse JSON!")
                completion(nil, err, Status.parsingFailure)
            }
        }
    }
    
    public func toHTTPStatus(completion:@escaping(HTTPURLResponse?,Error?, Status) -> Void){
        runRequest(){
            (data:Data?,response:URLResponse?, err:Error?) in
            if let code = response! as? HTTPURLResponse{
                completion(code, err, Status.success)
            }else{
                print("couldnt parse HTTP Status Code!")
                completion(nil, err, Status.parsingFailure)
            }
        }
    }
    
    
}
