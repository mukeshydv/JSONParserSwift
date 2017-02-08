# JSONParserSwift

[![CI Status](http://img.shields.io/travis/mukeshydv/JSONParserSwift.svg?style=flat)](https://travis-ci.org/mukeshydv/JSONParserSwift)
[![Version](https://img.shields.io/cocoapods/v/JSONParserSwift.svg?style=flat)](http://cocoapods.org/pods/JSONParserSwift)
[![License](https://img.shields.io/cocoapods/l/JSONParserSwift.svg?style=flat)](http://cocoapods.org/pods/JSONParserSwift)
[![Platform](https://img.shields.io/cocoapods/p/JSONParserSwift.svg?style=flat)](http://cocoapods.org/pods/JSONParserSwift)

Server sends the all JSON data in black & white format i.e its all strings & we make hard efforts to typecast them into their respective datatypes as per our model class.

Now, Is there a magic that comes between the server data and our code & magically converts those strings into the required respective datatypes as per our model classes.


## Requirements

## Installation

JSONParserSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JSONParserSwift"
```
## Implementation

To parse any JSON String or Dictionary to your model you have to create a class and subclass it by `ParsableModel`. Now you will need to create the properties in the model class with same name as their keys in the JSON data.

### Example

If you have to parse following JSON String:
```json
{
  "employeeId": 1002,
  "employeeName": "Demo Employee",
  "employeeEmail": "abc@def.com",
  "employeeDepartment": "IT"
}
```
You will need to create model as follows:

```swift
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
  let employee: Employee = try JSONParserSwift.parse(string: jsonString)
  // Use employee object here
} catch {
  print(error)
```

The model can have reference to other model's which are subclass of `ParsableModel` or it can have `Array` of models.

**Note:** Currently this version do not support Optionals with Int and Array of Optional types. So prefer to use NSNumber for number related datas.

## Author

Mukesh Yadav, mails4ymukesh@gmail.com

## License

JSONParserSwift is available under the MIT license. See the LICENSE file for more info.
