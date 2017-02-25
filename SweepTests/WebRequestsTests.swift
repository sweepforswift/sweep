//
//  WebRequestsTests.swift
//  Sweep
//
//  Created by Reiker Seiffe on 2/24/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import XCTest
@testable import Sweep


class WebRequestsTests: XCTestCase {
    
    var webRequests:WebRequests!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        webRequests = WebRequests()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        webRequests = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetRequest(){
        
        let request = webRequests.getRequest(url: "http://reikerseiffe.com/projects")
        
        print("Request: \(request!)")
        
        XCTAssert(request != nil)
        
    }
    
    
    /***************************************************************/
    //
    //
    //GET REQUESTS
    //
    //
    /***************************************************************/
    
    func testGetJSONRequest(){
        let expectation = self.expectation(description: "async request")
        let json = webRequests.getRequest(url: "http://reikerseiffe.com/firstProject")?.toJSON{
            (response:Any?, err:Error?, status: Status) in
            print("response \(response)")
            print("error \(err)")
            expectation.fulfill()
            
            XCTAssert(response != nil && status == Status.success)
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetCodeRequest(){
        let expectation = self.expectation(description: "async")
        let code = webRequests.getRequest(url: "http://reikerseiffe.com/status")?.toHTTPStatus{
            (response:HTTPURLResponse?, err:Error?) in
            print("response \(response?.statusCode)")
            print("error \(err)")
            expectation.fulfill()
            
            XCTAssert(response?.statusCode == 200)
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testGetCodeRequestBadURL(){
        let expectation = self.expectation(description: "async")
        let code = webRequests.getRequest(url: "http://reikerseiffe.com/statu")?.toHTTPStatus{
            (response:HTTPURLResponse?, err:Error?) in
            print("response \(response?.statusCode)")
            print("error \(err)")
            expectation.fulfill()
            
            XCTAssert(response?.statusCode == 404)
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testGetJSONRequestBadURL(){
        let expectation = self.expectation(description: "async request")
        let json = webRequests.getRequest(url: "http://reikerseiffe.com/firstProjec")?.toJSON{
            (response:Any?, err:Error?, status: Status) in
            print("response \(response)")
            print("error \(err)")
            print("Status \(status)")
            expectation.fulfill()
            
            XCTAssert(status == Status.badRequest)
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    /***************************************************************/
    //
    //
    //POST REQUESTS
    //
    //
    /***************************************************************/
    
    
    func testPostJSONRequest(){
        let expectation = self.expectation(description: "async request")
        let json = webRequests.postRequest(url: "http://reikerseiffe.com/projectByName", postString: "name=notevote")?.toJSON{
            (response:Any?, err:Error?, status: Status) in
            print("response \(response)")
            print("error \(err)")
            expectation.fulfill()
            
            XCTAssert(response != nil && status == Status.success)
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testPostCodeRequest(){
        let expectation = self.expectation(description: "async")
        let code = webRequests.postRequest(url: "http://reikerseiffe.com/status", postString: "nam=Reiker")?.toHTTPStatus{
            (response:HTTPURLResponse?, err:Error?) in
            print("response \(response?.statusCode)")
            print("error \(err)")
            expectation.fulfill()
            
            XCTAssert(response?.statusCode == 200)
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testPostCodeRequestBadURL(){
        let expectation = self.expectation(description: "async")
        let code = webRequests.postRequest(url: "http://reikerseiffe.com/statu", postString: "name=reiker")?.toHTTPStatus{
            (response:HTTPURLResponse?, err:Error?) in
            print("response \(response?.statusCode)")
            print("error \(err)")
            expectation.fulfill()
            
            XCTAssert(response?.statusCode == 404)
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testPostJSONRequestBadURL(){
        let expectation = self.expectation(description: "async request")
        let json = webRequests.postRequest(url: "http://reikerseiffe.com/firstProjec", postString: "name=reiker")?.toJSON{
            (response:Any?, err:Error?, status: Status) in
            print("response \(response)")
            print("error \(err)")
            print("Status \(status)")
            expectation.fulfill()
            
            XCTAssert(status == Status.badRequest)
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
