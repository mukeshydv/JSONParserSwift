//
//  Serialization.swift
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

class Serialization {
	
	static func getDictionaryFromArray(array: [Any]) -> [Any] {
		var resultingArray: [Any] = []
		
		for element in array {
			let elementValue = getValue(value: element)
            resultingArray.append(elementValue)
		}
		
		return resultingArray
	}
	
	static func getDictionaryFromObject(object: Any) -> [String: Any] {
		var dictionary: [String: Any] = [:]
		
		var mirror: Mirror? = Mirror(reflecting: object)
		repeat {
			for property in mirror!.children {
				if let propertyName = property.label {
					if propertyName == "some" {
						var mirror: Mirror? = Mirror(reflecting: property.value)
						repeat {
							for childProperty in mirror!.children {
								if let propertyName = childProperty.label {
                                    if let value = property.value as? JSONKeyCoder {
                                        if let userDefinedKeyName = value.key(for: propertyName) {
                                            dictionary[userDefinedKeyName] = getValue(value: childProperty.value)
                                        } else {
                                            dictionary[propertyName] = getValue(value: childProperty.value)
                                        }
                                    } else {
                                        dictionary[propertyName] = getValue(value: childProperty.value)
                                    }
								}
							}
							mirror = mirror?.superclassMirror
						} while mirror != nil
					} else {
                        
                        if let value = object as? JSONKeyCoder {
                            if let userDefinedKeyName = value.key(for: propertyName) {
                                dictionary[userDefinedKeyName] = getValue(value: property.value)
                            } else {
                                dictionary[propertyName] = getValue(value: property.value)
                            }
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
	
	private static func getValue(value: Any) -> Any {
		if let numericValue = value as? NSNumber {
			return numericValue
        } else if let boolValue = value as? Bool {
            return boolValue
        } else if let stringValue = value as? String {
            return stringValue
        } else if let arrayValue = value as? Array<Any> {
			return getDictionaryFromArray(array: arrayValue)
		} else {
			let dictionary = getDictionaryFromObject(object: value)
			if dictionary.count == 0 {
				return NSNull()
			} else {
				return dictionary
			}
		}
	}
	
}
