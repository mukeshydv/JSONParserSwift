//
//  ParsableModel.swift
//  Copyright (c) 2017 Mukesh Yadav <mails4ymukesh@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

/// This is the helper class defining the multiple methods to parse the different representation of JSON.
public class JSONParserSwift {
	
	/// Use this method to parse the string format of JSON into corresponding Model.
	///```
	///	do {
	///		let response: YourModel = try JSONParserSwift.parse(string: jsonString)
	///	} catch let parseError {
	///		print(parseError)
	///	}
	///```
	///
	/// - Parameter string: string representation of JSON.
	/// - Returns: Returns the parsed object. The type of object must be given explicitly at calling time of the method.
	/// - Throws: Throws an error if given string is not a valid JSON.
	public static func parse<Type: JSONParsable>(string: String) throws -> Type {
		if let data = string.data(using: .utf8) {
			do {
				return try parse(data: data)
			} catch {
				throw error
			}
		} else {
			throw JSONParserSwiftError.cannotParseJsonString
		}
	}
	
	/// Use this method to parse the string format of JSON into array of Numbers or Strings.
	///```
	///	do {
	///		let responseArray = try JSONParserSwift.parse(string: jsonArrayString)
	///	} catch let parseError {
	///		print(parseError)
	///	}
	///```
	///
	/// - Parameter string: string representation of JSON.
	/// - Returns: Returns the parsed array.
	/// - Throws: Throws an error if given string is not a valid JSON.
	public static func parse(string: String) throws -> Array<Any> {
		if let data = string.data(using: .utf8) {
			do {
				return try parse(data: data)
			} catch {
				throw error
			}
		} else {
			throw JSONParserSwiftError.cannotParseJsonString
		}
	}
	
	/// Use this method to parse the string format of JSON into array of Parsable Model.
	///```
	///	do {
	///		let responseArray: Array<YourModel> = try JSONParserSwift.parse(string: jsonArrayString)
	///	} catch let parseError {
	///		print(parseError)
	///	}
	///```
	///
	/// - Parameter string: string representation of JSON.
	/// - Returns: Returns the parsed array.
	/// - Throws: Throws an error if given string is not a valid JSON.
	public static func parse<Type: ParsableModel>(string: String) throws -> Array<Type> {
		if let data = string.data(using: .utf8) {
			do {
				let result: Array<Type> = try parse(data: data)
				return result
			} catch {
				throw error
			}
		} else {
			throw JSONParserSwiftError.cannotParseJsonString
		}
	}
	
	/// Use this method to parse the `Data` representation of the JSON.
	///```
	///	do {
	///		let response: YourModel = try JSONParserSwift.parse(data: jsonData)
	///	} catch let parseError {
	///		print(parseError)
	///	}
	///```
	///
	/// - Parameter data: data represenatation of the JSON.
	/// - Returns: Returns the parsed object. The type of object must be given explicitly at calling time of the method.
	/// - Throws: Throws an error if given data is not a valid JSON.
	public static func parse<Type: JSONParsable>(data: Data) throws -> Type {
		do {
			let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
			if let dictionary = dictionary as? [String: Any] {
				return Type(dictionary: dictionary)
			} else {
				throw JSONParserSwiftError.cannotParseJsonString
			}
		} catch {
			throw error
		}
	}
	
	/// Use this method to parse the `Data` representation of the JSON into array of Numbers or Strings.
	///```
	///	do {
	///		let responseArray: Array<Any> = try JSONParserSwift.parse(data: jsonArrayData)
	///	} catch let parseError {
	///		print(parseError)
	///	}
	///```
	///
	/// - Parameter data: data represenatation of the JSON.
	/// - Returns: Returns the parsed object.
	/// - Throws: Throws an error if given data is not a valid JSON.
	public static func parse(data: Data) throws -> Array<Any> {
		do {
			let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
			if let array = array as? [Any] {
				return try parse(array: array)
			} else {
				throw JSONParserSwiftError.cannotParseJsonString
			}
		} catch {
			throw error
		}
	}
	
	/// Use this method to parse the `Data` representation of the JSON into Parsable Model array.
	///```
	///	do {
	///		let responseArray: Array<YourModel> = try JSONParserSwift.parse(data: jsonArrayData)
	///	} catch let parseError {
	///		print(parseError)
	///	}
	///```
	///
	/// - Parameter data: data represenatation of the JSON.
	/// - Returns: Returns the parsed object.
	/// - Throws: Throws an error if given data is not a valid JSON.
	public static func parse<Type: ParsableModel>(data: Data) throws -> Array<Type> {
		do {
			let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
			if let array = array as? [[String: Any]] {
				let result: Array<Type> = parse(array: array)
				return result
			} else {
				throw JSONParserSwiftError.cannotParseJsonString
			}
		} catch {
			throw error
		}
	}
	
	/// Use this method to parse the `Dictionary` into Objects.
	///
	/// - Parameter dictionary: dictionary represenatation of the JSON.
	/// - Returns: Returns the parsed object. The type of object must be given explicitly at calling time of the method.
	public static func parse<Type: JSONParsable>(dictionary: [String: Any]) -> Type {
		return Type(dictionary: dictionary)
	}
	
	/// Use this method to parse the `Array` into array of Numbers or Strings.
	///
	/// - Parameter array: array represenatation of the JSON.
	/// - Returns: Returns the parsed object array.
	/// - Throws: Throws an error if given array is not of Numbers or Strings.
	public static func parse(array: [Any]) throws -> Array<Any> {
		var resultArray = [Any]()
		if (array.count > 0) {
			if let firstElement = array.first as? [String: Any] {
				throw JSONParserSwiftError.invalidJsonArrayType("Unexpected dictionary type: " + firstElement.description)
			} else {
				for element in array {
					resultArray.append(element)
				}
			}
		}
		return resultArray
	}
	
	/// Use this method to parse the `Array` into array of Parsable Models.
	///
	/// - Parameter array: array represenatation of the JSON.
	/// - Returns: Returns the parsed object array.
	public static func parse<Type: ParsableModel>(array: [[String: Any]]) -> Array<Type> {
		var resultArray = [Type]()
		if (array.count > 0) {
			for element in array {
				let parsedObject: Type = JSONParserSwift.parse(dictionary: element)
				resultArray.append(parsedObject)
			}
		}
		return resultArray
	}
	
	public static func getJSON(object: Any) throws -> String {
		
		var objectToParse = object
		
		if let arrayObject = object as? Array<Any> {
			objectToParse = getDictionaryFromArray(array: arrayObject)
		} else {
			objectToParse = getDictionaryFromObject(object: object)
		}
		
		do {
			let jsonData = try JSONSerialization.data(withJSONObject: objectToParse)
			if let jsonString = String(data: jsonData, encoding: .utf8) {
				return jsonString
			}
			throw JSONParserSwiftError.cannotConvertToString
		} catch {
			throw error
		}
	}
	
	private static func getDictionaryFromArray(array: [Any]) -> [Any] {
		var resultingArray: [Any] = []
		
		for element in array {
			resultingArray.append(getValue(value: element))
		}
		
		return resultingArray
	}
	
	private static func getDictionaryFromObject(object: Any) -> [String: Any?] {
		var dictionary: [String: Any?] = [:]
		
		var mirror: Mirror? = Mirror(reflecting: object)
		repeat {
			for property in mirror!.children {
				if let propertyName = property.label {
					if propertyName == "some" {
						var mirror: Mirror? = Mirror(reflecting: property.value)
						repeat {
							for property in mirror!.children {
								if let propertyName = property.label {
									if property.value == nil {
										dictionary[propertyName] = nil
									} else {
										dictionary[propertyName] = getValue(value: property.value)
									}
								}
							}
							mirror = mirror?.superclassMirror
						} while mirror != nil
					} else {
						if property.value == nil {
							dictionary[propertyName] = nil
						} else {
							dictionary[propertyName] = getValue(value: property.value)
						}
					}
				}
			}
			mirror = mirror?.superclassMirror
		} while mirror != nil
		
		return dictionary
	}
	
	private static func getValue(value: Any) -> Any? {
		if let stringValue = value as? String {
			return stringValue
		} else if let boolValue = value as? Bool {
			return boolValue
		} else if let numericValue = value as? NSNumber {
			return numericValue
		} else if let arrayValue = value as? Array<Any> {
			return getDictionaryFromArray(array: arrayValue)
		} else {
			let dictionary = getDictionaryFromObject(object: value)
			if dictionary.count == 0 {
				return nil
			} else {
				return dictionary
			}
		}
	}
}

enum JSONParserSwiftError: Error {
	case cannotParseJsonString
	case invalidJsonArrayType(String)
	case cannotConvertToString
}
