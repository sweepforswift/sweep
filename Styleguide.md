# Style Guide

## Braces

### Closing Braces
There should not be any whitespace between closing braces and closing parenthesis.
Examples that violate this rule (The $ appears directly before the violation):
```swift
[].map({ }$ )
[].map({ }$\t)
```

### Opening Brace Spacing
Opening braces should be preceded by a single space and on the same line as the declaration.
Examples that violate this rule:
```swift
func abc($){\n}
func abc()$\n\t{ }
[].map($){  }
[].map$( { } )
if let a = $b{ }
while a == $b{ }
```

## Characters

### Colon
Colons should be next to the identifier when specifying a type and next to the key in dictionary literals.
Examples that satisfy rule:
```swift
let abc: Void\n
let abc: [Void: Void]\n
let abc: (Void, Void)\n
```

### Comma
There should be no space before and one after any comma.
Examples that satisfy this rule:
```swift
func abc(a: String, b: String) { }
abc(a: "string", b: "string")
enum a { case a, b, c }
```

### Trailing Comma
Trailing commas in arrays and dictionaries literals should be avoided. Trailing commas in multiline collection should be enforced
Examples that satisfy this rule:
```swift
let foo = [1, 2, 3]
let example = [ 1,\n 2,\n 3,\n]
```
Examples that violate this rule
```swift
let foo = [1, 2, 3$,]
```

### Trailing Semicolon
Lines should not have trailing semicolons

## Closures

### Parameters
Closure parameters should be on the same line as opening brace.
Examples that violate this rule:
```swift
[1, 2].map {\n ↓number in\n number + 1 \n}
```

### Ending Indentation
The end of the closure should have the same amount of indentation as the beginning.
Examples that satisfy this rule:
```swift
SignalProducer(values: [1, 2, 3])
  .startWithNext { number in
       print(number)
   }
```

### Empty Parenthesis
When using trailing closures, empty paraenthesis should be avoided after the method call.
Use ```[1, 2].map { $0 + 1 }``` over ```[1, 2].map$() { $0 + 1 }```

### Expresions
Closure expresions should have a single space inside each brace.


### Unused Closure Parameter
Unused parameter in a closure should be replaced with _.
Use ```[1, 2].map { _ in 3 }``` instead of ```[1, 2].map { $number in return 3}```

## Files

### Leading Whitespace
Files should not contain leading whitespace.

### Line Length
Lines should not span too many characters. Will warn at 120 characters and error at 200 characters.

### Mark
MARK Comment should be in valid format.
Examples that satisfy this rule:
```
// MARK: good
// MARK: - good
// MARK: -
```

### Todo
TODOs and FIXMEs should be avoided

### Trailing Newliine
Files should have a single trailing newline

### Trailing Whitespace
Lines should not have trailing whitespace

## Functions

### Cyclomatic Complexity
Complexity of functions bodies should be limited
Examples that violate this rule:
```swift
func f1() {
  if true {
      if true {
            if false {}
        }
	}
	if false {}
	let i = 0

	switch i {
	  case 1: break
	  case 2: break  
	  case 3: break
	  case 4: break 
	  default: break\n  
	}
	for _ in 1...5 {
	    guard true else {
	          return    
      }  
    }
}
```

### Empty Parameters
Prefer () -> over Void ->
Use ```let abc: () -> Void = {}``` instead of ```let abc: $Void -> Void = {}```

### Function Body Length
Functions bodies should not span too many lines. Warns at 40 lines, errors at 100 lines.

### Function Parameter Count
Number of function parameters should be low. Warns at 5, errors at 8.

### Operator Function Whitespace
Operators should be surrouned by a single whitespace when defining them.
Use ```func <| (lhs: Int, rhs: Int) -> Int {}``` instead of ```func <|(lhs: Int, rhs: Int) -> Int {}```

### Redundant Void Return
Returning Void in a function declaration is redundant
Use ```func foo() {}\n``` instead of ```func foo()$ -> Void {}```

### Returning Whitespace
Return arrow and return type should be separated by a single space or on a separate line.
Use ```func abc() -> Int {}``` instead of ```func abc()$->Int {}```

### Valid Docs
Documented declarations should be valid.

## Statements

### Control Statements
If, for, while, and do statements shouldn't wrap their conditionals in parenthesis

### Empty Count
isEmpty should be used over comparing count to zero.
Use ```[Int]().isEmpty``` instead of ```[Int]().↓count == 0```

### Explicit Init
Explicitly calling .init() should be avoided

### For Where
Where clauses are preferred over a single if inside a for.
Use ```for user in users where user.id == 1 { }``` instead of
```
for user in users {
   if user.id == 1 { }
}
```

### Force Try
Force tries should be avoided.

### Nesting
Types should be nested at most 1 level deep, and statements should be nested at most 5 levels deep.

### Private Outlets
IBOutlets should be private to avoid leaking UIKit to higher layers.

### Private Unit Tests
Unit tests marked private are silently skipped.

### Redundant Discardable Let
Prefer _ = foo() over let _ = foo() when discarding a result from a function.

### Redundant Nil Coalescing
Nil coalescing operator is only evaluated if the left hand side is nil, coalescing operator with nil as the right hand side is redundant
Example that satisfies this rule:
```swift
var myVar: Int?
myVar ?? 0
```

### Redundant Optional Initialization
Initializing an optional variable with nil is redundant

### Shorthand Operators
Prefer shorthand operators (+=, -=, *=, /=) over doing the operation and assigning

### Statement Position
Else and catch should be on the same line, one space after the previous declaration

### Switch Case on Newline
Cases inside a switch should always be on a newline

### Syntactic Sugar
Shorthand syntactic surgar should be used, i.e. [Int] instead of Array<Int>

### Unused Enumerated
When the index or the item is not used, .enumerated can be removed

### Unused Optional Bining
Prefer != nil over let _ =

## Types

### Generic Type Names
Generic type name should only contain alphanumeric characters, start with an uppercase character and span between 1 and 20 characters.

### Identifier Names
Identifier names should only contain alphanumeric characters and start with a lowercase character or should only contain capital letters.

### Implicit Getter
Computed read-only properties should avoid using the get keyword.

### Large Tuple
Tuples shouldn't have too many members. Create a custom type instead. Warns at 2 parameters, errors at 3.

### Type Body Length
Type bodies should not span too many lines. Warns at 200 lines, errors at 350 lines.

### Type Name
Type name should only contain alphanumeric characters, start with an uppercase character and span between 3 and 40 characters in length