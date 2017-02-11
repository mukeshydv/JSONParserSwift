//
//  ParsableModel.swift
//  ReflectionDemo
//
//  Created by Mukesh Yadav on 07/02/17.
//  Copyright © 2017 Mukesh Yadav. All rights reserved.
//

import Foundation

/// Defines a protocol that must be conform by every model class which can be parsed by `JSONParserSwift`.
public protocol JSONParsable: NSObjectProtocol {
	/// This method will be used to initialize the model with the data in dictionary.
	///
	/// - Parameter dictionary: `Dictionary` object to be parsed.
	init(dictionary: [String: Any])
}

/// Defines a base model which will be super class of every model classes which can be parsed by `JSONParserSwift` framework.
open class ParsableModel: NSObject, JSONParsable {
	
	/// This method will be used to initialize the model with the data in dictionary.
	///
	/// - Parameter dictionary: `Dictionary` object to be parsed.
	public required init(dictionary: [String : Any]) {
		super.init()
		var mirror: Mirror? = Mirror(reflecting: self)
		repeat {
			for property in mirror!.children {
				initialize(for: property, dictionary: dictionary)
			}
			mirror = mirror?.superclassMirror
		} while mirror != nil
	}
	
	private func initialize(for property: Mirror.Child, dictionary: [String: Any]) {
		if let propertyName = property.label {
			if let value = dictionary[propertyName] {
				
				if value is NSNull {
					setValue(nil, forKey: propertyName)
				} else {
					if let dictionaryValue = value as? [String: Any] {
						
						if let dynamicClass = getDynamicClassType(value: property.value) {
							let dynamicObject = dynamicClass.init(dictionary: dictionaryValue)
							setValue(dynamicObject, forKey: propertyName)
						}
					} else if let arrayValue = value as? [Any] {
						let parsedArray = parse(property: property, array: arrayValue)
						setValue(parsedArray, forKey: propertyName)
					} else {
						setValue(value, forKey: propertyName)
					}
				}
			}
		}
	}
	
	private func parse(property: Mirror.Child, array: [Any]) -> [Any] {
		var resultingArray = [Any]()
		for element in array {
			if let dictionaryValue = element as? [String: Any] {
				
				if let dynamicClass = getDynamicClassType(value: property.value) {
					let dynamicObject = dynamicClass.init(dictionary: dictionaryValue)
					resultingArray.append(dynamicObject)
				}
				
			} else {
				resultingArray.append(element)
			}
		}
		
		return resultingArray
	}
	
	private func getDynamicClassType(value: Any) -> JSONParsable.Type? {
		var dynamicType = String(describing: type(of: value))
		dynamicType = dynamicType.replacingOccurrences(of: "Optional<", with: "")
		dynamicType = dynamicType.replacingOccurrences(of: "Array<", with: "")
		dynamicType = dynamicType.replacingOccurrences(of: ">", with: "")
		
		let bundle = Bundle(for: type(of: self))
		if let name = bundle.infoDictionary?[kCFBundleNameKey as String] as? String {
			dynamicType = name + "." + dynamicType
		}
		
		if let dynamicClass = NSClassFromString(dynamicType) as? JSONParsable.Type {
			return dynamicClass
		}
		return nil
	}
	
	/// This method will be called if your model have some properties which do not support Key-Value coding(KVC). override this method to add your own implementation.
	///
	/// - Parameters:
	///   - value: The value which needs to be initialized in model class.
	///   - key: key which do not support the KVC.
	override open func setValue(_ value: Any?, forUndefinedKey key: String) {
		print("\nWARNING: The class '\(NSStringFromClass(type(of: self)))' is not key value coding-compliant for the key '\(key)'\n There is no support for optional type, array of optionals or enum properties.\nAs a workaround you can implement the function 'setValue forUndefinedKey' for this.\n")
	}
	
}
