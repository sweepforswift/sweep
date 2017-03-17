# Sweep for Swift

Sweep is a Swift library used to simplify several common tasks that are used in most iOS applications today.

This library is under active development and will continue to be modified and improved over time. The current release is an "alpha". We encourage everyone to contribute to make this library even better.

## Table of Contents

- [Goals](#goals)
- [Contribution Guide](#contributing)
- [Installation](#installation)
- [Testing](#testing)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

## Goals

Releasing the source code for this library is meant to empower other developers and organizations through the simplification of common tasks in iOS development. In addition, we hope that public review and contribution of this code base will help strengthen and improve capability of the library.

We hope to see this library grow and develop in the open source community and increase in complexity so that those who use it can get right into the development of their applications.

## Contributing

Anyone is encouraged to contribute to the project by [forking](https://help.github.com/articles/fork-a-repo) and submitting a pull request. (If you are new to GitHub, you might start with a [basic tutorial](https://help.github.com/articles/set-up-git).)

Please read our [contributing](https://github.com/sweepforswift/sweep/blob/master/CONTRIBUTING.md) guide before making any pull requests. Please also read our [style](https://github.com/sweepforswift/sweep/blog/master/Styleguide.md) guide before making pull requests to make sure your code follows our standard.

## Installation
Download the latest verion of our library from the [releases](https://github.com/sweepforswift/sweep/releases) section. This will give you the prebuilt framework that can be added to the project directly.

If you would like to build our library from scratch, clone this project and build it using Xcode.

Lastly, if you are using the Swift Package Manager, you can add Sweep as a dependency by adding the following line to your dependencies array

```.Package(url: "https://github.com/sweepforswift/sweep", majorVersion: 0)```

## Testing

You may also optionally switch to the SweepTests scheme and run the unit tests to see the results. All pull requests are checked against TravisCI for passing tests and HoundCI for style violations.

## Usage

All of our documentation can be found [here](https://sweepforswift.io/docs). If you find a mistake in the docs or would like to contribute to them, they can be found [here](https://github.com/sweepforswift/docs).

## Credits

####Icon
Icon from www.flaticon.com
E.g.: Icon made by Freepik from www.flaticon.com

## License
The Sweep library is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).
