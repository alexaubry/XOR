# XOR

![Swift 3.0.1](https://img.shields.io/badge/Swift-3.0.1-ee4f37.svg)
![License](https://img.shields.io/badge/License-MIT-000000.svg)
[![Build Status](https://travis-ci.org/alexaubry/XOR.svg?branch=master)](https://travis-ci.org/alexaubry/XOR)
[![codecov](https://codecov.io/gh/alexaubry/XOR/branch/master/graph/badge.svg)](https://codecov.io/gh/alexaubry/XOR)
[![Twitter : @leksantoine](https://img.shields.io/badge/Twitter-%40leksantoine-6C7A89.svg)](https://twitter.com/leksantoine)

XOR is a Swift Library that allows you to compute the [eXclusive OR](https://en.wikipedia.org/wiki/Exclusive_or) of two Integer arrays.

[Documentation](https://alexaubry.github.io/XOR/docs/)

## What is XOR ?

Exclusive OR (XOR) compares the bits of two numbers. The operations returns a new number whose bits are set to 1 where the input bits are different and are set to 0 where the input bits are the same.

![XOR Example](assets/bitwiseXOR.png)

*Image courtesy of [The Swift Programming Language Book](https://swift.org/documentation/#the-swift-programming-language), CC by 4.0*

This algorithm is often used for cryptography and math.

## Installation

### Swift Package Manager

Add this line to your `Package.swift` file:

~~~swift
.Package(url: "https://github.com/alexaubry/XOR.git", majorVersion: 1, minor: 0)
~~~

### CocoaPods

Add this line to your `Podfile`:

~~~ruby
pod 'XOR' ~> '1.0.0'
~~~

## Usage

You can compute the XOR of any Array whose `Element` type conform to Swift's native `Integer` protocol (that is `Int`, `UInt8`, ...).

To do so, use the `xor(key:)` method on an Integer array.

~~~swift
let array = [0x1a,0x2b,0x3c,0x4d,0x5e,0x6f]
let key = [0x84,0x1b,0x76,0x91,0xfa,0x55]

let result = array.xor(key: key)

// result = [0x9e,0x30,0x4a,0xdc,0xa4,0x3a]
~~~

You can also get the original message back by calling the `xor(key:)` method on a XOR result using the same key.

~~~swift
let originalMessage = result.xor(key: key)
// originalMessage = [0x1a,0x2b,0x3c,0x4d,0x5e,0x6f]
~~~

## Implementation Details

- If a component (either the receiver or the key) has a smaller length that the other component, padding will be added to it. This allows you to have a key longer than the message, and vice-versa.

*Examples:*

~~~swift
let message = [0x1a,0x2b]
let key = [0x3c,0x4d,0x5e,0x6f]
// message will be XOR-ed as [0x00,0x00,0x1a,0x2b]
~~~

~~~swift
let message = [0x1a,0x2b,0x3c,0x4d]
let key = [0x5e,0x6f]
// the key will be [0x00,0x00,0x5e,0x6f]
~~~

- Any common prefix between the receiver and the key will be stripped, in order to remove any leading `0`s from the output.

*Example:*

~~~swift
let message = [0x1a,0x2b,0x3c]
let key = [0x1a,0x4d,0x5e]
// message will be XOR-ed as [0x2b,0x3c] and the key will be [0x4d,0x5e]
~~~

*Enjoy❓*
