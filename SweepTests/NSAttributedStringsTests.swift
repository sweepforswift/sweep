//
//  NSAttributedStringsTests.swift
//  Sweep
//
//  Created by Will Mock on 2/24/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import XCTest
import Foundation


class NSAttributedStringsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    func testChangedFont(){
        
        let intialString: String = "This is a testing string."
        
        let fontNameValue = "Thonburi"
        
        var testString: NSMutableAttributedString = NSMutableAttributedString(string: intialString)
        
        testString = testString.changeFontType(fontName: fontNameValue)
        
        let attributes = testString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, testString.length))
        
        if let font = (((attributes[intialString]! as? Dictionary<String, Any>)?["NSFont"]!) as? [String])?.contains(fontNameValue){
            XCTAssert(font)
        }
        
    }
    
    func testIsTextColorChanged(){
        
        let intialString: String = "This is a testing string."
        
        let color: UIColor = UIColor.blue
        
        var testString: NSMutableAttributedString = NSMutableAttributedString(string: intialString)
        
        testString = testString.changeFontColor(color: color)
        
        let attributes = testString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, testString.length))
        
        print(attributes)
        
        XCTAssert(attributes["NSColor"] != nil)
    }
    
    
    func testIsHighlighted(){
        
        let intialString: String = "This is a testing string."
        
        var testString: NSMutableAttributedString = NSMutableAttributedString(string: intialString)
        
        testString = testString.highlight()
        
        let attributes = testString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, testString.length))
        
        XCTAssert(attributes["NSBackgroundColor"] != nil)
    }
    
    func testIsBoldOrIsItalic(){
        
        let intialString: String = "This is a testing string."
        
        var testString: NSMutableAttributedString = NSMutableAttributedString(string: intialString)
        
        testString = testString.addConstraints(style: .italic, fontSize: 15)
        
        let attributes = testString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, testString.length))
        
        let font = ((((attributes[intialString]! as? Dictionary<String, Any>)?["NSFont"]!)!) as? UIFont)
        
        let descriptor = font?.fontDescriptor
        let symTraits = descriptor?.symbolicTraits
        
        if let trait = symTraits?.contains(.traitBold){
            if trait{
                XCTAssert(trait)
            }
        }else if let trait = symTraits?.contains(.traitItalic){
            if trait{
                XCTAssert(trait)
            }
        }
    
    }
}
