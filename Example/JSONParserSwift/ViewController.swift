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
		"{\"test\": \"Test Data 4\"}" +
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class TestModel: ParsableModel {
	var test: String?
}

