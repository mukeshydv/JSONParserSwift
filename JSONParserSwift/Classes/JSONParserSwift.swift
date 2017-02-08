//
//  JSONParserSwift.swift
//  ReflectionDemo
//
//  Created by Mukesh Yadav on 06/02/17.
//  Copyright © 2017 Mukesh Yadav. All rights reserved.
//

import Foundation

class JSONParserSwift {
	
	static func parse<Type: JSONParsable>(string: String) throws -> Type {
		if let data = string.data(using: .utf8) {
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
		} else {
			throw JSONParserSwiftError.cannotParseJsonString
		}
	}
	
	static func parse<Type: JSONParsable>(dictionary: [String: Any]) -> Type {
		return Type(dictionary: dictionary)
	}
	
}

enum JSONParserSwiftError: Error {
	case cannotParseJsonString
}
