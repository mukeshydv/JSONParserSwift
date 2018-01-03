//
//  ParsingTest.swift
//  JSONParserSwiftTests
//
//  Created by OneAssist on 1/3/18.
//  Copyright © 2018 Mukesh Yadav. All rights reserved.
//

import XCTest
@testable import JSONParserSwift

class ParsingTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    private func getJSONString(from fileName: String) -> String {
        
        let bundle = Bundle(for: ParsingTest.self)
        let path = bundle.path(forResource: fileName, ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        
        return String(data: data!, encoding: .utf8)!
    }
    
    func testSimpleObjectParsing() {
        let json = getJSONString(from: "simple_object")
        
        do {
            let simpleObject: SimpleObject = try JSONParserSwift.parse(string: json)
            
            XCTAssertEqual(simpleObject.name, "Test Name", "Name parsing failed")
            XCTAssertEqual(simpleObject.address, "Test Address", "Address parsing failed")
        } catch {
            XCTFail()
        }
    }
    
    func testArrayOfObjects() {
        let json = getJSONString(from: "simple_object_array")
        
        do {
            let simpleObjects: [SimpleObject] = try JSONParserSwift.parse(string: json)
            
            XCTAssertEqual(simpleObjects.count, 5, "Array parsing failed")
        } catch {
            XCTFail()
        }
    }
    
}

class SimpleObject: ParsableModel {
    var name: String?
    var address: String?
}
