# Sweep for Swift

Swift extension library used to simplify several common tasks that are used in most iOS applications today.

This application is under active development and will continue to be modified and improved over time. The current release is an "alpha."

## Table of Contents

- [Goals](#goals)
- [Contribution Guide](#contributing)
- [Installation](#installation)
- [Features](#usage)
- [Usage](#usage)
    - [Arrays](#arrays)
        - [Average](#average)
    - [JSON-Parser](#json-parser)
        - [Parse For Strings](#parse-for-strings)
        - [Parse For Data](#parse-for-data)
        - [Parse To Objects](#parse-to-objects)
        - [JSONAble Protocol](#jsonable-protocol)
        - [To JSON](#to-json)
    - [Web-Requests](#web-requests)
        - [Get and Delete requests](#get-delete)
        - [Post and Put requests](#post-put)
        - [Running the Request](#running-request)
        	- [To Json](#toJson)
        	- [To HTTP Status Code](#http-status)
    - [NSMutableAttributedStrings](#nsmutableattributedstrings)
        - [Change Font Type](#change-font-type)
        - [Change Font Color](#change-font-color)
        - [Highlight Text](#highlight-text)
        - [Add Constraints](#add-constraints)
- [Credits](#credits)
- [License](#license)

## Goals

Releasing the source code for this library is meant to empower other developers and organizations through the simplification of common tasks in iOS development. In addition, we hope that public review and contribution of this code base will help strengthen and improve capability of the library.

We hope to see this library grow and develop in the open source community and increase in complexity so that those who use it can get right into the development of their applications.

## Contributing

Anyone is encouraged to contribute to the project by [forking](https://help.github.com/articles/fork-a-repo) and submitting a pull request. (If you are new to GitHub, you might start with a [basic tutorial](https://help.github.com/articles/set-up-git).)

Please read our [contributing](https://github.com/msmith95/sweep/blob/master/CONTRIBUTING.md) guide before making any pull requests.

## Installation
Download the latest verion of our library from the [releases](https://github.com/msmith95/sweep/releases) section. There will be two options, one marked as sweep-base, the other as sweep-firebase. Sweep-base includes just the base library while sweep-firebase includes the base library as well as the Firebase integration. Only use the Firebase one if you plan on integrating Firebase into your application.

If you would like to build our library from scratch, clone this project and build it using Xcode. You may also optionally run the testing scheme to see the results of the unit tests.

## Usage

### Arrays

####Average
The `average` function takes in no parameters and returns an average of type `Double` on the arrays summation. This function works only on Ints, Doubles, and Floats. Also, catches the exception of an empty Array.
```swift
  let intArray: [Int] = [1,2,3,4,5]//sum = 15
  let floatArray: [Float] = [1.25,2.5,3.75]//sum = 7.5
  let doubleArray: [Double] = [5.0, 0.6,4.2, 0.2, 2.5]//sum = 12.5
  let emptyArray = Array<Int>()// sum = 0
  //Getting Averages on all Sequences that have the Avergable protocol.
  let intAverage = intArray.average() //intAverage = 3.0
  let floatAverage = floatArray.average() //floatAverage = 2.5
  let doubleAverage = doubleArray.average() //doubleAverage = 2.5
  let emptyAverage = emptyArray.average() // average = 0.0
```

### JSON Parser

#### Parse For Strings
The `parse` function takes in a JSON string called jsonString as a `String` and returns an either a `Dictionary<String,Any>?` or `[Any]?` based upon the type of the variable the call is being assigned to. In the case of malformed JSON, nil will be returned.

For a `Dictionary`
```swift
let json = "{\"someKey\": 42.0,\"anotherKey\": {\"someNestedKey\": true}}"
let object : [String : Any]? = JSONParser.parse(jsonString: json)
if let object = object {
    //work with return dictionary
}
```
`object` will now hold the unwrapped `Dictionary<String,Any>` that corresponds to the JSON object.

For an `Array`
```swift
let json = "[\"hello\", 3, true]"
let array : [Any]? = JSONParser.parse(jsonString: json)
if let array = array {
    //work with return array
}
```
`array` will now hold the unwrapped `[Any]` that corresponds to the JSON array.

#### Parse For Data

The `parse` function can also take in `Data` called jsonData, parse it, and returns an either a `Dictionary<String,Any>?` or `[Any]?` based upon the type of the variable the call is being assigned to. In the case of malformed JSON, nil will be returned.

```swift
let json = "{\"someKey\": 42.0,\"anotherKey\": {\"someNestedKey\": true}}".data(using: .utf8)
let object : [String : Any]? = JSONParser.parse(jsonData: json!)
if let object = object{
    //work with return object
}
```
`object` now holds the unwrapped `Dictionary<String,Any>` that corresponds to the JSON obect. The same syntax also holds for dealing with arrays.

#### Parse To Objects

The `parse` function can also be used to convert JSON to instances of classes that conform to the JSONAble protocol that is shown below. The JSON is parsed and is then passed to a required initializer that allows control over what the JSON data gets assigned to.

For a `Dictionary<String,Any>`
```swift
class FakeObject: JSONAble{
    var test: Int?
    required init(json: [String:Any]){
        test = json["someKey"] as! Int?
    }
}

let json = "{\"someKey\": 42.0,\"anotherKey\": {\"someNestedKey\": true}}"
let object : [FakeObject]? = JSONParser.parse(toObject: json)
if let rObject = object?[0]{
    //rObject now holds the singular object
}
```
`rObject` holds the object instance filled with the JSON data.

For an `Array`
```swift
let json = "[{\"someKey\": 42.0,\"anotherKey\": {\"someNestedKey\": true}},{\"someKey\": 43.0,\"anotherKey\": {\"someNestedKey\": true}}]"
let object : [FakeObject]? = JSONParser.parse(toObject: json)
if let object = object{
    //now have access to the array of objects
}
```
`object` now holds the array of created objects filled with the JSON data.

#### JSONAble Protocol
The JSONAble protocol ensures that objects have an initializer that accepts a `Dictionary<String,Any>`.

```swift
public protocol JSONAble{
    init(json: [String:Any])
}
```

Additionally, the JSONAble protocol allows these objects to be converted into JSON strings from their instances due to the `toJSON` method shown below.

#### To JSON

For a singular object
```swift
let json = "{\"someKey\": 42.0,\"anotherKey\": {\"someNestedKey\": true}}"
let object : [FakeObject]? = JSONParser.parse(toObject: json)
if let object = object{
    let jsonString = rObject.toJSON()
}
```
`jsonString` now holds the result of turing the object into a JSON string.

For an `Array`
```swift
let json = "[{\"someKey\": 42.0,\"anotherKey\": {\"someNestedKey\": true}},{\"someKey\": 43.0,\"anotherKey\": {\"someNestedKey\": true}}]"
let object : [FakeObject]? = JSONParser.parse(toObject: json)
if let object = object{
    let jsonString = rObjects.toJSON()
}
```
`jsonString` now holds the JSON string form of the array.

### Web Requests

The `WebRequests` class allows for easier web requests by turning common HTTP methods into functions runable on the class. All functions on this class will take in either just a URL or both a URL and POST data. Each function will return an instance of the `Request` class. Because of this it is possible to chain `WebRequests` functions with functions on the `Request` object (example in the Running the Request section below).

The `Request` class has 3 functions on it, the first being `runRequest` which will use the `request:URLRequest?` variable to run a session and return a closure of type `Data?`, `URLResponse?`, and `Error?`. The other two functions are explained below.


#### Get and Delete Requests

##### Get Requests
The `getRequest` function will take in a URL that is passed in as a `String`. This will return an instantiated object of type `Request` that has the URL set and the `.httpMethod` set to "GET". If the url could not be formed to type `URL` than nil will be returned.

```swift
	let getRequest = webRequests.getRequest(url: "http://example.com/API/test")

	guard let request = getRequest else{
		print("request was nil")
		return
	}
	//run code....
```

##### Get Requests
The `deleteRequest` function is very similar to the get request and will also take in a URL that is passed in as a `String`. This will return an instantiated object of type `Request` that has the URL set and the `.httpMethod` set to "DELETE". If the url could not be formed to type `URL` than nil will be returned.

```swift
	let deleteRequest = webRequests.deleteRequest(url: "http://example.com/API/user/1")

	guard let request = deleteRequest else{
		print("request was nil")
		return
	}
	//run code....
```

#### Post and Put Requests
##### Post Requests
The `postRequest` function takes in a URL that is passed in as a `String` and a string of data to pass through in the method body. This will return an instantiated object of type `Request` that has the URL set and the `.httpMethod` set to "POST" and the `.HTTPBody` set to the post string. If the url could not be formed to type `URL` than nil will be returned.

```swift
	let postRequest = webRequests.postRequest(url: "http://example.com/API/login", postString: "username=user&password=test")

	guard let request = postRequest else{
		print("request was nil")
		return
	}
	//run code....
```

##### Put Requests
The `putRequest` function is similar to the post request and takes in a URL that is passed in as a `String` and a string of data to pass through in the method body. This will return an instantiated object of type `Request` that has the URL set and the `.httpMethod` set to "PUT" and the `.HTTPBody` set to the post string. If the url could not be formed to type `URL` than nil will be returned.

```swift
	let putRequest = webRequests.putRequest(url: "http://example.com/API/user/1", putString: "username=user2")

	guard let request = putRequest else{
		print("request was nil")
		return
	}
	//run code....
```

#### Running the request
When creating web requests with the `WebRequests` class, `WebRequests` will return a `Request` object with the method to run the session and a `JSON` and HTTP code parser. This allows the methods just to be called on the object returned or the ability to chain multiple methods together such as a get request and the parsing it as `JSON`. These functions will recieve a closure with the data needed.
Example:

```swift
	webRequests.getRequest(url: "http://example.com/users")?.toJSON{
			(response:Any?, err:Error?, status: Status) in
        print("response \(response)")
        print("error \(err)")
        print("Status \(status)")
  }
```

Currently the toJSON will reurn and `Any?` object that can then be parsed using the JSONable extention included in the library. This is planned to be made default in the future. `HTTP status codes` can also be obtained by this class by calling `toHTTPStatus`. This function will also recieve a closure with the data needed, simply call .statusCode on the response to obtain the code..

```swift
    webRequests.getRequest(url: "http://example.com/users")?.toHTTPStatus{
        (response:HTTPURLResponse?, err:Error?, status:Status) in
        print("response \(response?.statusCode)")
        print("error \(err)")
    }
```

### NSMutableAttributedStrings

#### Change Font Type
The `changeFontType` function takes in the name of a `UIFont` name as a String and returns an `NSMutableAttributedString` with the `UIFont` that was passed in appied to the text. The `UIFont` will only be applied if the string that was passed in matched one of the available font names exactly.
```swift
let intialString: String = "Hello World!"
let fontNameValue = "Thonburi"     
var testString: NSMutableAttributedString = NSMutableAttributedString(string: intialString)       
testString = testString.changeFontType(fontName: fontNameValue)
```
`testString` will now hold the updated `NSMutableAttributedString` returned by `testString.changeFontType(fontName: fontNameValue)`
#### Change Font Color
The `changeFontColor` function takes a `UIColor` and a `NSRange?` which will default to the entirety of the string if a subrange is not provided in this parameter.The function will return an `NSMutableAttributedString` with the `UIColor` that was passed in appied to the text.

Without `NSRange?` Specified
```swift
let intialString: String = "Hello World!" 
let color: UIColor = UIColor.blue
var testString: NSMutableAttributedString = NSMutableAttributedString(string: intialString)
testString = testString.changeFontColor(color: color)
```

`testString` will now hold the updated `NSMutableAttributedString` font returned by `testString.changeFontColor(color: color)`

With `NSRange?` Specified
```swift
let intialString: String = "Hello World!" 
let color: UIColor = UIColor.blue
var testString: NSMutableAttributedString = NSMutableAttributedString(string: intialString)
testString = testString.changeFontColor(color: color, range: NSMakeRange(3, 5))
```

`testString` will now hold the updated `NSMutableAttributedString` font returned by `testString.changeFontColor(color: color, range: NSMakeRange(3, 5))`
#### Highlight Text
The `highlight` function optionally takes in an `NSRange?` which will default to the entirety of the string if a subrange is not provided in this parameter. The `highlight` function returns an `NSMutableAttributedString` with the `NSBackgroundColorAttributeName` changed to yellow.

Without `NSRange?` Specified
```swift
let intialString: String = "Hello World"
var testString: NSMutableAttributedString = NSMutableAttributedString(string: intialString)
testString = testString.highlight()
```
`testString` will now hold the updated `NSMutableAttributedString` returned by `testString.highlight()`

With `NSRange?` Specified
```swift
let intialString: String = "Hello World!" 
var testString: NSMutableAttributedString = NSMutableAttributedString(string: intialString)
testString = testString.highlight(range: NSMakeRange(3, 5))
```

`testString` will now hold the updated `NSMutableAttributedString` font returned by `testString.highlight(range: NSMakeRange(3, 5))`
#### Add Constraints
The `addConstraints` function takes in a Style `enum` , an `Int` for the `fontSize` ,and optionally takes in an `NSRange?` which will default to the entirety of the string if a subrange is not provided in this parameter. The `addConstraints` function returns an `NSMutableAttributedString` with the `enum` selection applied.

Without `NSRange?` Specified
```swift
let intialString: String = "Hello World!"
var testString: NSMutableAttributedString = NSMutableAttributedString(string: intialString)
testString = testString.addConstraints(style: .italic, fontSize: 15)
```
`testString` will now hold the updated `NSMutableAttributedString` returned by `testString.highlight()`

With `NSRange?` Specified
```swift
let intialString: String = "Hello World!"
var testString: NSMutableAttributedString = NSMutableAttributedString(string: intialString)
testString = testString.addConstraints(style: .italic, fontSize: 15, range: NSMakeRange(3, 5))
```
`testString` will now hold the updated `NSMutableAttributedString` font returned by `testString.addConstraints(style: .italic, fontSize: 15, range: NSMakeRange(3, 5))`
## Credits

####Icon
Icon from www.flaticon.com 
E.g.: Icon made by Freepik from www.flaticon.com

## License
The Sweep library is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).
