![Json_Parser_Image](json_parser.png)

[![CI Status](http://img.shields.io/travis/mukeshydv/JSONParserSwift.svg?style=flat)](https://travis-ci.org/mukeshydv/JSONParserSwift)
[![Version](https://img.shields.io/cocoapods/v/JSONParserSwift.svg?style=flat)](http://cocoadocs.org/docsets/JSONParserSwift)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://mit-license.org)
[![Platform](https://img.shields.io/cocoapods/p/JSONParserSwift.svg?style=flat)](http://cocoadocs.org/docsets/JSONParserSwift)
[![Language](https://img.shields.io/badge/swift-4.0-orange.svg)](https://developer.apple.com/swift)

Server sends the all JSON data in black and white format i.e. its all strings & we make hard efforts to typecast them into their respective datatypes as per our model class.

Now, there's comes `JSONParserSwift` framework between the server data and our code to magically converts those strings into the required respective datatypes as per our model classes without writing any code.

## Requirements

## Installation

JSONParserSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JSONParserSwift"
```
### Swift 3 support
For using the framework on Swift 3 use the branch [swift-3.2](https://github.com/mukeshydv/JSONParserSwift/tree/swift-3.2) or install version `1.1.3` using CocoaPods, use following line in your Podfile:

```ruby
pod 'JSONParserSwift', '1.1.3'
```

## Implementation

To parse any JSON String or Dictionary to your model you have to create a class and subclass it by `ParsableModel`. Now you will need to create the properties in the model class. You can create these properties with same name or different name as keys in json string. If you declare properties with same name as key in json then you need to declare only properties. But if you want to have different names for properties and keys then you need to conform protocol `JSONKeyCoder` and implement method 
`func key(for key: String) -> String?`

### Example

If you have to parse following JSON String:
```json
{
  "responseStatus": {
    "statusCode": 101,
    "message": "Error Message"
  },
  "responseData": {
    "employeeId": 1002,
    "employeeName": "Demo Employee",
    "employeeEmail": "abc@def.com",
    "employeeDepartment": "IT"
  }
}
```
You will need to create models as follows:

```swift
class BaseResponse: ParsableModel {
  var responseStatus: ResponseStatus?
  var responseData: Employee?
}

class ResponseStatus: ParsableModel {
  var statusCode: NSNumber?
  var message: String?
}

class Employee: ParsableModel {
  var employeeId: NSNumber?
  var employeeName: String?
  var employeeEmail: String?
  var employeeDepartment: String?
}
```

Now to parse the JSON you just need to call following method:

```swift
do {
  let baseResponse: BaseResponse = try JSONParserSwift.parse(string: jsonString)
  // Use base response object here
} catch {
  print(error)
}
```
The model can have reference to other model's which are subclass of `ParsableModel` or it can have `Array` of models.

### Get JSON String from Object

To get the JSON string from an object you just have to call `JSONParserSwift.getJSON(object: NSObject)` method to get the JSON.

If you want to have different keys and properties name then Conform to protocol `JSONKeyCoder` and implement its method `key(for key: String) -> String?` as given below:

```swift
class TestModel: JSONKeyCoder {

    var test: String?
    var number: Double = 0
    var boolValue: Bool = false
    var anotherTest: TestModel?
    var array: [TestModel]?
    
    public func key(for key: String) -> String? {
        switch key {
        case "boolValue":   // Properties name
            return "bool_value"     // Key in response
        case "anotherTest":
            return "another_key"
        default:
            return nil
        }
    }
}
```

If you want to convert the model object into JSON string then call method getJSON as given below:

```swift
// Prepare Test Model
let testModel: TestModel = TestModel()
testModel.test = "xyz"
testModel.number = 10.0
testModel.boolValue = true
    
let anotherTestModel = TestModel()
anotherTestModel.test = "abc"
anotherTestModel.number = 23
anotherTestModel.boolValue = false
    
testModel.anotherTest = anotherTestModel
testModel.array = [anotherTestModel]

do {
    // Convert into json string
    let jsonString = try JSONParserSwift.getJSON(object: testModel)
    print("Json String : \(jsonString)")
} catch {
    print(error)
}
```

The JSON string for the above code will be:

```json
{
  "bool_value":true,
  "number":10,
  "test":"xyz",
  "array":[
    {
      "bool_value":false,
      "number":23,
      "test":"abc",
      "array": null,
      "another_key": null
    }
  ],
  "another_key": {
    "bool_value":false,
    "number":23,
    "test":"abc",
    "array": null,
    "another_key": null
  }
 }
```

**Note:** Currently this version do not support Optionals with Int and Array of Optional types. So prefer to use NSNumber for number related datas.

## Author

* [**Mukesh Yadav**](https://github.com/mukeshydv)
* [**Chanchal Chauhan**](https://github.com/chanchalchauhan)

See also the list of [contributors](https://github.com/mukeshydv/JSONParserSwift/graphs/contributors) who participated in this project.

## License

JSONParserSwift is available under the MIT license. See the LICENSE file for more info.
