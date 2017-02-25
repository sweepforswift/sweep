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
        //Inits of Arrays
        //------------------------------------------------------------------
        /* Already written
        let cashArray: [Int] = [100,200]
        let toolsArray: [String] = ["Saw", "PowerDrill"]
        let stringArray: [String] = ["a","b","c"]
        let emptyStringArray: [String] = []
         */
        let intArray: [Int] = [1,2,3,4,5] //15 avg = 3
        let floatArray: [Float] = [1.25,2.5,3.75] //7.5 avg = 2.5
        let doubleArray: [Double] = [5.0, 0.6,4.2, 0.2, 2.5] // 12.5 avg = 2.5
        let emptyArray = Array<Int>() //0 avg = 0.0
        //Function calls
        //Contruction of Take
        //------------------------------------------------------------------
       /* let stringTake3 = stringArray.take(index: 3)
        let stringTake2 = stringArray.take(index: 2)
        let stringTake = stringArray.take(index: 0)
        let emptyTake = emptyStringArray.take(index: 5)//Reaching out of bounds
        let emptyTake2 = emptyStringArray.take(index: 0)//Taking from nothing */
        //Construction of Average
        //-----------------------------------------------------------------
        let intAverage = intArray.average()
        let floatAverage = floatArray.average()
        let doubleAverage = doubleArray.average()
        let emptyAverage = emptyArray.average()
        //Testing Prints
        //------------------------------------------------------------------
        //Use of Take
       /* print(stringTake3)
        print(stringTake2)
        print(stringTake)
        print(emptyTake2)
        print(emptyTake) */
        //------------------------------------------------------------------
        //Use of Average
        print(intAverage)
        print(floatAverage)
        print(doubleAverage)
        print(emptyArray)
        //Tests
        //------------------------------------------------------------------
        //Use of Take
       // XCTAssert(stringTake3 == [])
        //XCTAssert(stringTake2 == ["a","b","c"])
        //XCTAssert(stringTake == ["a"])
        //XCTAssert(emptyTake2 == [])
        //XCTAssert(emptyTake == [])
        //------------------------------------------------------------------
        //Use of Average
        XCTAssert(intAverage == 3)
        XCTAssert(floatAverage == 2.5)
        XCTAssert(doubleAverage == 2.5)
        XCTAssert(emptyAverage == 0.0)
        //------------------------------------------------------------------
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
}
