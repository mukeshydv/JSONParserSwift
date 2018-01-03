//
//  SerializationTest.swift
//  JSONParserSwiftTests
//
//  Created by Mukesh Yadav on 1/3/18.
//  Copyright © 2018 Mukesh Yadav. All rights reserved.
//

import XCTest
@testable import JSONParserSwift

class SerializationTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSimpleObject() {
        let simpleObjectInput = SimpleObject(dictionary: [:])
        simpleObjectInput.name = "Test Name"
        simpleObjectInput.address = "Test Address"
        
        do {
            let jsonString = try JSONParserSwift.getJSON(object: simpleObjectInput)
            
            let simpleObjectOutput: SimpleObject = try JSONParserSwift.parse(string: jsonString)
            
            XCTAssertEqual(simpleObjectInput.name, simpleObjectOutput.name, "Name is different")
            XCTAssertEqual(simpleObjectInput.address, simpleObjectOutput.address, "Address is different")
            
        } catch {
            XCTFail()
        }
    }
}
