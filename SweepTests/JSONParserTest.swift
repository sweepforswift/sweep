//
//  JSONParserTest.swift
//  Sweep
//
//  Created by Michael Smith on 2/24/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import XCTest
@testable import Sweep

class JSONParserTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParsesJSONObject() {
        let json = "{\"someKey\": 42.0,\"anotherKey\": {\"someNestedKey\": true}}"
        let object : [String : Any] = JSONParser.parse(jsonString: json)!
        XCTAssert(object["someKey"] as? Int == 42)
        
    }
    
    func testParsesJSONArray() {
        let json = "[\"hello\", 3, true]"
        let object : [Any] = JSONParser.parse(jsonString: json)!
        XCTAssert(object[0] as? String == "hello")
    }
    
    func testRejectsMalformedObject(){
        let json = "{\"someKey\": 42.0,\"anotherKey\": {\"someNestedKey\": true}"
        let object : [String : Any]? = JSONParser.parse(jsonString: json)
        XCTAssert(object == nil)
    }
    
    func testRejectsMalformedArray(){
        let json = "[\"hello\", 3, true"
        let object : [Any]? = JSONParser.parse(jsonString: json)
        XCTAssert(object == nil)
    }
    
    func testCanParseObject(){
        let json = "{\"someKey\": 42.0,\"anotherKey\": {\"someNestedKey\": true}}"
        let object : [FakeObject]? = JSONParser.parse(toObject: json)
        let rObject = object?[0]
        XCTAssert(rObject?.test == 42)
    }
    
    func testRejectsMalformedJSONForObject(){
        let json = "{\"someKey\": 42.0,\"anotherKey\": {\"someNestedKey\": true}"
        let object : [FakeObject]? = JSONParser.parse(toObject: json)
        let rObject = object?[0]
        XCTAssert(rObject == nil)
    }
    
    func testObjectCanBecomeJSONString(){
        let json = "{\"someKey\": 42.0,\"anotherKey\": {\"someNestedKey\": true}}"
        let object : [FakeObject]? = JSONParser.parse(toObject: json)
        let rObject = object?[0]
        let jsonString = rObject!.toJSON()
        XCTAssertEqual(jsonString, "{\"test:\" 42}")
    }
    
    func testArrayCanBecomeJSONString(){
        let json = "[{\"someKey\": 42.0,\"anotherKey\": {\"someNestedKey\": true}},{\"someKey\": 43.0,\"anotherKey\": {\"someNestedKey\": true}}]"
        let object : [FakeObject]? = JSONParser.parse(toObject: json)
        let rObjects = object
        let jsonString = rObjects!.toJSON()
        XCTAssertEqual(jsonString, "[{\"test:\" 42},{\"test:\" 43}]")
    }
    
}

class FakeObject: JSONAble{
    var test: Int?
    required init(json: [String:Any]){
        test = json["someKey"] as! Int?
    }
}
