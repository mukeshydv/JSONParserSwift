//
//  ViewController.swift
//  JSONParserSwift
//
//  Created by mukeshydv on 02/11/2017.
//  Copyright (c) 2017 mukeshydv. All rights reserved.
//

import UIKit
import JSONParserSwift

class ViewController: UIViewController {

	let jsonString = "[" +
		"{\"test\": \"Test Data 1\"}," +
		"{\"test\": \"Test Data 2\"}," +
		"{\"test\": \"Test Data 3\"}," +
        "null," +
		"{\"test\": true}" +
	"]"
	
	let arrayOfNumbers = "[101, 102, 103, 104]"
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		do {
			let array: Array<TestModel> = try JSONParserSwift.parse(string: jsonString)
			print(array)
			
			if let data = jsonString.data(using: .utf8) {
				let parsedArray: Array<TestModel> = try JSONParserSwift.parse(data: data)
				print(parsedArray)
			}
			
			if let data = arrayOfNumbers.data(using: .utf8) {
				let parsedNumbers = try JSONParserSwift.parse(data: data)
				print(parsedNumbers)
			}
		} catch {
			print(error)
		}
        
        let json = "[{\"number\":12.0045,\"boolValue\":true,\"test\":\"Test data 1\",\"anotherTest\":null,\"array\":null},{\"number\":12.0045,\"boolValue\":true,\"test\":\"Test data 1\",\"anotherTest\":{\"number\":12.0045,\"boolValue\":true,\"test\":\"Test data 1\",\"anotherTest\":null,\"array\":null},\"array\":[{\"number\":12.0045,\"boolValue\":true,\"test\":\"Test data 1\",\"anotherTest\":null,\"array\":null},{\"number\":12.0045,\"boolValue\":true,\"test\":\"Test data 1\",\"anotherTest\":null,\"array\":null}]}]"
        
        do {
            let testModel: [TestModel] = try JSONParserSwift.parse(string: json)
            
            let reverseDict = try JSONParserSwift.getJSON(object: testModel)
            
            print("Test Passed: \(json == reverseDict)")
            
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class TestModel: ParsableModel {
	var test: String?
    var number: Double = 0
    var boolValue: Bool = false
    var anotherTest: TestModel?
    var array: [TestModel]?
}

