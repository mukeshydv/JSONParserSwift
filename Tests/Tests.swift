import UIKit
import XCTest
import JSONParserSwift

class Tests: XCTestCase {
	
	var json: String!
	
    override func setUp() {
        super.setUp()
		json = "[{\"number\":12.0045,\"boolValue\":true,\"test\":\"Test data 1\",\"anotherTest\":null,\"array\":null},{\"number\":12.0045,\"boolValue\":true,\"test\":\"Test data 1\",\"anotherTest\":{\"number\":12.0045,\"boolValue\":true,\"test\":\"Test data 1\",\"anotherTest\":null,\"array\":null},\"array\":[{\"number\":12.0045,\"boolValue\":true,\"test\":\"Test data 1\",\"anotherTest\":null,\"array\":null},{\"number\":12.0045,\"boolValue\":true,\"test\":\"Test data 1\",\"anotherTest\":null,\"array\":null}]}]"
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testJSONParserSwift() {
		do {
			let testModel: [TestModel] = try parseJSON(json: json)
			
			let reverseDict = try getJSONString(testModel: testModel)
			
			print("Test Passed: \(json == reverseDict)")
			
			XCTAssert(json == reverseDict, "Pass")
			
		} catch {
			print(error)
		}
	}
	
	func parseJSON(json: String) throws -> [TestModel] {
		do {
			return try JSONParserSwift.parse(string: json)
		} catch {
			throw error
		}
	}
	
	func getJSONString(testModel: Any) throws -> String {
		do {
			return try JSONParserSwift.getJSON(object: testModel)
		} catch {
			throw error
		}
	}
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
			let testModel: [TestModel] = try! self.parseJSON(json: self.json)
			
			_ = try! self.getJSONString(testModel: testModel)
			
			XCTAssert(true)
        }
    }
    
}

class TestModel: ParsableModel {
	var test: String?
	var number: Double = 0
	var boolValue: Bool = false
	var anotherTest: TestModel?
	var array: [TestModel]?
}
