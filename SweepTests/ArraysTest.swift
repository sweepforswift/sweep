//
//  ArraysTest.swift
//  Sweep
//
//  Created by Teodor Ivanov on 2/25/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import XCTest
@testable import Sweep

class ArraysTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let intArray: [Int] = [1,2,3,4,5] //15 avg = 3
        let floatArray: [Float] = [1.25,2.5,3.75] //7.5 avg = 2.5
        let doubleArray: [Double] = [5.0, 0.6,4.2, 0.2, 2.5] //
        let emptyArray = Array<Int>()
        let intAverage = intArray.average()
        let floatAverage = floatArray.average()
        let doubleAverage = doubleArray.average()
        let emptyAverage = emptyArray.average()
        print(intAverage)
        print(floatAverage)
        print(doubleAverage)
        print(emptyArray)
        XCTAssert(intAverage == 3)
        XCTAssert(floatAverage == 2.5)
        XCTAssert(doubleAverage == 2.5)
        XCTAssert(emptyAverage == 0.0)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
}
