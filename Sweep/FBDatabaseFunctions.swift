//
//  FBDatabaseFunctions.swift
//  Sweep
//
//  Created by Will Mock on 2/25/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

public extension FIRDatabaseReference{
    
    /**
     Gets the data at a specified path in a firebase database
     
     - parameter path: the full path to the location desired
     
     - parameter completionHandler: the completion handler for getting the data
     
     - returns: Void
     */
    public func getDataAtPath(path: String, completionHandler:@escaping(FIRDataSnapshot)->Void ) -> Void {
        
        let db = self.child(path)
        
            db.observeSingleEvent(of: .value, with: { (snapshot) in
                
                completionHandler(snapshot)
                
            }) { (error) in
                print(error.localizedDescription)
            }
    }
    
    /**
     Writes the data at a specified path in a firebase database
     
     - parameter path: the full path to the location desired. The key for this entry should be the last part of this path
     
     - parameter data: the data that you desire to be written to the path
     
     - parameter completionHandler: the completion handler for getting the data
     
     - returns: Void
     */
    public func writeDataAtPath(path: String, data: [String: Any], completion: @escaping(FIRDatabaseReference)->Void){
        
        let db = self.child(path)
        
        db.setValue(data){ error, ref in
            completion(ref)
        }
        
    }
    
    /**
     Writes the data at a specified path in a firebase database
     
     - parameter path: the full path to the location desired. The key for this entry should be the last part of this path
     
     - parameter data: the data that you desire to be written to the path
     
     - returns: Void
     */
    public func writeDataAtPath(path: String, data: [String: Any]){
        
        let db = self.child(path)
        
        db.setValue(data)        
    }
    
    /**
     Gets the values of similar keys to the one provided in the function parameters
     
     - parameter path: the full path to the location desired
     
     - parameter likeValue: the value that you want to find a key similar to
     
     - parameter completion: the completion handler for getting the data
     
     - returns: Void
     */
    public func getLikeValues(path: String, likeValue: String, completion:@escaping([String: Any]?)->Void){
        
        let like = likeValue.lowercased()
        
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        ref.getDataAtPath(path: path){ snapshot in
            
            var array = snapshot.value as? [String: Any]
            
            if let keys = array?.keys{
                
                for key in keys{
                    
                   let keyLower = key.lowercased()
                    
                    print(keyLower)
                    print(likeValue)
                    if (keyLower.contains(like)){
                        //print(key)
                    }else{
                        array?.removeValue(forKey: key)
                    }
                }
            }
            
            completion(array)
        }
    }
    
}

class FireBaseDBHelper: NSObject {
    
    
    
}
