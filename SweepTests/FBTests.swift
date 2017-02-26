//
//  FBTests.swift
//  Sweep
//
//  Created by Will Mock on 2/25/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import XCTest
import FirebaseCore
import FirebaseDatabase

class FBTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        FIRApp.configure()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        FIRApp.defaultApp()?.delete(){ blank in
            
        }
        
    }
    
    func testCanRetrieveDataAtSinglePath(){
        
        let expectation = self.expectation(description: "async request")
        
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        ref.getDataAtPath(path: "users"){ snapshot in
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        
        
    }
    
    func testCanRetrieveDataWithTrailingSlash(){
        
        let expectation = self.expectation(description: "async request")
        
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        ref.getDataAtPath(path: "users/"){ snapshot in
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        
        
    }
    
    func testCanRetrieveDataAtMultiplePath(){
        
        let expectation = self.expectation(description: "async request")
        
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        ref.getDataAtPath(path: "/users/alovelace/"){ snapshot in
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        
        
    }
    
    func testCanWriteData(){
        
        let expectation = self.expectation(description: "async request")

        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        ref.writeDataAtPath(path: "/users/Mike", data: ["Age": 24]){ _ in
            
            ref.getDataAtPath(path: "/users/Mike"){ snapshot in
                
                let array = snapshot.value as? [String: Any]
                
                //print(array)
                
                if array?["Age"] as? Int == 24{
                    expectation.fulfill()
                }
            }
            
        }
        
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testGetLikeValues() {
        let expectation = self.expectation(description: "async request")
        
        var arr: [String: Any] = [:]
        
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        ref.getLikeValues(path: "/users", likeValue: "mik"){ dict in
            
            if let dict = dict{
                arr = dict
                print(arr)
            }
            
            expectation.fulfill()
            
        }
        
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    


    
}
