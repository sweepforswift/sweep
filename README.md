# Sweep for Swift

Swift extension library used to simplify several common tasks that are used in most iOS applications today.

This application is under active development and will continue to be modified and improved over time. The current release is an "alpha."

## Table of Contents

- [Goals](#goals)
- [Contribution Guide](#contributing)
- [Features](#usage)
- [Usage](#usage)
    - [Arrays](#arrays)
        -METHODS GO HERE
    - [SafeArrays](#safearrays)
        -METHODS GO HERE
    - [JSON-Parser](#json-parser)
        -METHODS GO HERE
    - [Web-Requests](#web-requests)
        -METHODS GO HERE
    - [ProgrammaticUI-Constraints](#programmatic-ui-constraints)
        -METHODS GO HERE
    - [NSMutableAttributedStrings](#nsmutableattributedstrings)
        - [Change Font Type](#change-font-type)
        - [Change Font Color](#change-font-color)
        - [Highlight Text](#highlight-text)
        - [Add Constraints](#add-constraints)
- [Credits](#credits)
- [License](#license)

## Goals

Releasing the source code for this library is meant to empower other developers and organizations through the simplification of common tasks in iOS development. In addition, public review and contribution to the application’s code base will help strengthen and improve the platform.

We hope to see this library grow and develop in the open source community and increase in complexity so that those who use it can get right into the development of thier applications.

## Contributing

Anyone is encouraged to contribute to the project by [forking](https://help.github.com/articles/fork-a-repo) and submitting a pull request. (If you are new to GitHub, you might start with a [basic tutorial](https://help.github.com/articles/set-up-git).)

## Usage

### Arrays

### SafeArrays

### JSON Parser

### Web Requests

### Programmatic UI Constraints

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

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.

The project utilizes code licensed under the terms of the GNU General Public License and therefore is licensed under GPL v2 or later.

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.