<p align="center">
 <a href="https://www.coronawarn.app/en/"><img src="https://raw.githubusercontent.com/corona-warn-app/cwa-documentation/master/images/CWA_title.png" width="400"></a>
</p>

<hr />

<p align="center">
    <a href="https://api.reuse.software/info/github.com/corona-warn-app/json-functions-swift" title="REUSE Status">
      <img src="https://api.reuse.software/badge/github.com/corona-warn-app/json-functions-swift">
    </a>
</p>
<p align="center">
    <a href="#usage">Usage Guide</a> •
    <a href="#requirements">Requirements</a> •
    <a href="#documentation">Documentation</a> •
    <a href="#support-and-feedback">Support and Feedback</a> •
    <a href="#how-to-contribute">How to contribute</a> •
    <a href="#licensing">Licensing</a> •
    <a href="https://www.coronawarn.app/en/">Web Site</a>
</p>
<hr />

# Corona-Warn-App: json-functions-swift

A native Swift implementation of JsonFunctions.

JsonFunctions (JFN) is a generic logic engine that is capable of processing functions that are described in a JSON format. It is a compatible extension of [JsonLogic](http://jsonlogic.com).

## Instalation

#### Using Swift Package Manager

if you use Swift Package Manager add the following in dependencies:

        dependencies: [
        .package(
            url: "https://github.com/corona-warn-app/json-functions-swift", from: "2.0.3"
        )
    ]

## Usage

You simply import the module and either call the applyRule global method:

```swift
import jsonlogic

let rule =
"""
{ "var" : "name" }
"""
let data =
"""
{ "name" : "Jon" }
"""

//Example parsing
let result: String? = try? applyRule(rule, to: data)

print("result = \(String(describing: result))")
```

The ```applyRule``` will parse the rule then apply it to the ```data``` and try to convert the
result to
 the
inferred return
type,
if it fails an error will be thrown.

If you need to apply the same rule to multiple data then it will be better to parse the rule once.
You can do this by initializing a ```JsonRule``` object with the rule and then calling
```applyRule```.

```swift

//Example parsing
let jsonlogic = try JsonLogic(rule)

var result: Bool = jsonlogic.applyRule(to: data1)
result = jsonlogic.applyRule(to: data2)
//etc..

```

## Examples

#### Simple
```Swift
let rule = """
{ "==" : [1, 1] }
"""

let result: Bool = try JsonFunctions().applyRule(rule)
//evaluates to true
```

This is a simple test, equivalent to `1 == 1`.  A few things about the format:

  1. The operator is always in the "key" position. There is only one key per JsonLogic rule.
  1. The values are typically an array.
  1. Each value can be a string, number, boolean, array (non-associative), or null

#### Compound
Here we're beginning to nest rules.

```Swift
let rule = """
  {"and" : [
    { ">" : [3,1] },
    { "<" : [1,3] }
  ] }
"""
let result: Bool = try JsonFunctions().applyRule(rule)
//evaluates to true
```

In an infix language this could be written as:

```Swift
( (3 > 1) && (1 < 3) )
```

#### Data-Driven

Obviously these rules aren't very interesting if they can only take static literal data.
Typically `jsonLogic` will be called with a rule object and a data object. You can use the `var`
operator to get attributes of the data object:

```Swift
let rule = """
  { "var" : ["a"] }
"""
let data = """
  { a : 1, b : 2 }
"""
let result: Int = try JsonFunctions().applyRule(rule, to: data)
//evaluates to 1
```

If you like, we support to skip the array around values:

```Swift
let rule = """
  { "var" : "a" }
"""
let data = """
  { a : 1, b : 2 }
"""
let result: Int = try JsonFunctions().applyRule(rule, to: data)
//evaluates to 1
```

You can also use the `var` operator to access an array by numeric index:

```js
jsonLogic.apply(
  {"var" : 1 },
  [ "apple", "banana", "carrot" ]
);
// "banana"
```

Here's a complex rule that mixes literals and data. The pie isn't ready to eat unless it's cooler than 110 degrees, *and* filled with apples.

```Swift
let rule = """
{ "and" : [
  {"<" : [ { "var" : "temp" }, 110 ]},
  {"==" : [ { "var" : "pie.filling" }, "apple" ] }
] }
"""
let data = """
  { "temp" : 100, "pie" : { "filling" : "apple" } }
"""

let result: Bool = try JsonFunctions().applyRule(rule, to: data)
//evaluates to true
```

### Custom operators

You can register a custom operator

```Swift
import jsonlogic
import JSON

// the key is the operator and the value is a closure that takes as argument
// a JSON and returns a JSON
let customRules =
    ["numberOfElementsInArray": { (json: JSON?) -> JSON in                                 
        switch json {
        case let .Array(array):
            return JSON(array.count)
        default:
            return JSON(0)
        }
    }]

let rule = """
    { "numberOfElementsInArray" : [1, 2, 3] }
"""

// The value is 3
let value: Int = try JsonLogic(rule, customOperators: customRules).applyRule()
```

### Other operators

For a complete list of the supported operators and their usages see [jsonlogic operators](http://jsonlogic.com/operations.html).


## Requirements


| iOS      | tvOS       | watchOS    | macOS      |
| :------: |:----------:|:----------:|:----------:|
| >=11.0    | >=13.0     | >=6.0      | >=10.13    |

## Documentation

The full documentation for the Corona-Warn-App can be found in the [cwa-documentation](https://github.com/corona-warn-app/cwa-documentation) repository. The documentation repository contains technical documents, architecture information, and white papers related to this implementation.

## Support and Feedback

The following channels are available for discussions, feedback, and support requests:

| Type                     | Channel                                                |
| ------------------------ | ------------------------------------------------------ |
| **General discussion, issues, bugs**   | <a href="https://github.com/corona-warn-app/json-functions-swift/issues/new/choose" title="General Discussion"><img src="https://img.shields.io/github/issues/corona-warn-app/cwa-kotlin-jfn/question.svg?style=flat-square"></a> </a>   |
| **Other requests**    | <a href="mailto:corona-warn-app.opensource@sap.com" title="Email CWA Team"><img src="https://img.shields.io/badge/email-CWA%20team-green?logo=mail.ru&style=flat-square&logoColor=white"></a> |

## How to contribute

The German government has asked SAP and Deutsche Telekom AG to develop the Corona-Warn-App for Germany as open source software. Deutsche Telekom is providing the network and mobile technology and will operate and run the backend for the app in a safe, scalable and stable manner. SAP is responsible for the app development, its framework and the underlying platform. Therefore, development teams of SAP and Deutsche Telekom are contributing to this project. At the same time our commitment to open source means that we are enabling -in fact encouraging- all interested parties to contribute and become part of its developer community.

For more information about how to contribute, the project structure, as well as additional contribution information, see our [Contribution Guidelines](./CONTRIBUTING.md). By participating in this project, you agree to abide by its [Code of Conduct](./CODE_OF_CONDUCT.md) at all times.

## Repositories

A list of all public repositories from the Corona-Warn-App can be found [here](https://github.com/corona-warn-app/cwa-documentation/blob/master/README.md#repositories).


## Authors

This repository is forked from https://github.com/eu-digital-green-certificates/json-logic-swift which is again forked from the original repository https://github.com/advantagefse/json-logic-swift:
- Original: Christos Koninis, c.koninis@afse.eu, Copyright (c) 2019 Advantage FSE
- Enhancements and Modifications in this repository: Copyright (c) 2022-2023 SAP SE or an SAP affiliate company.


## License

Licensed under the **MIT License** (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at https://opensource.org/licenses/MIT.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the [LICENSE](./LICENSE) for the specific language governing permissions and limitations under the License.

Please see the [detailed licensing information](https://api.reuse.software/info/github.com/corona-warn-app/json-functions-swift) via the [REUSE Tool](https://reuse.software/) for more details.

The "Corona-Warn-App" logo is a registered trademark of The Press and Information Office of the Federal Government. For more information please see [bundesregierung.de](https://www.bundesregierung.de/breg-en/federal-government/federal-press-office).