//
//  JSONParserSwift.swift
//  ReflectionDemo
//
//  Created by Mukesh Yadav on 06/02/17.
//  Copyright © 2017 Mukesh Yadav. All rights reserved.
//

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
	
<<<<<<< HEAD
	public static func parse<Type: Array>(string: String) throws -> Array {
		
	}
	
=======
>>>>>>> 73ffc94237e681de9f349bf0da0c194a788e05d9
	/// Use this method to parse the `Data` representation of the JSON.
	///```
	///	do {
	///		let response: YourModel = try JSONParserSwift.parse(data: jsonData)
	///	} catch let parseError {
	///		print(parseError)
	///	}
	///```
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
	
	/// Use this method to parse the `Dictionary` into Objects.
	///
	/// - Parameter dictionary: dictionary represenatation of the JSON.
	/// - Returns: Returns the parsed object. The type of object must be given explicitly at calling time of the method.
	public static func parse<Type: JSONParsable>(dictionary: [String: Any]) -> Type {
		return Type(dictionary: dictionary)
	}
	
}

enum JSONParserSwiftError: Error {
	case cannotParseJsonString
}
