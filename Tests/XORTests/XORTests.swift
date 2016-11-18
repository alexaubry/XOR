/*
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   XORTests.swift
 *  Project         :   XOR
 *  Author          :   ALEXIS AUBRY RADANOVIC
 *
 *  License         :   The MIT License (MIT)
 *
 * ==---------------------------------------------------------------------------------==
 *
 *	The MIT License (MIT)
 *	Copyright (c) 2016 ALEXIS AUBRY RADANOVIC
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy of
 *	this software and associated documentation files (the "Software"), to deal in
 *	the Software without restriction, including without limitation the rights to
 *	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 *	the Software, and to permit persons to whom the Software is furnished to do so,
 *	subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in all
 *	copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 *	FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 *	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 *	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ==---------------------------------------------------------------------------------==
 */

import XCTest
@testable import XOR

///
/// A test case to check the behavior of the XOR operations.
///

class XORTests: XCTestCase {

    // MARK: - Core
    
    ///
    /// Tests applying a leading padding to an array.
    ///
    
    func testAddingPadding() {
       
        let targetCount = 10
        
        let exactCountArray = [Int](repeating: 1, count: 10)
        let paddedExactCountArray = exactCountArray.addingPadding(to: targetCount)
        
        XCTAssertEqual(exactCountArray.count, targetCount)
        XCTAssertEqual(exactCountArray, paddedExactCountArray)
        
        let smallerArray = [Int](repeating: 1, count: 5)
        let paddedSmallerArray = smallerArray.addingPadding(to: targetCount)
        
        XCTAssertEqual(paddedSmallerArray.count, targetCount)
        XCTAssertEqual(paddedSmallerArray, [0,0,0,0,0,1,1,1,1,1])
        
        let biggerArray = [Int](repeating: 1, count: 15)
        let paddedBiggerArray = biggerArray.addingPadding(to: targetCount)
        
        XCTAssertEqual(paddedBiggerArray.count, 15)
        XCTAssertEqual(paddedBiggerArray, biggerArray)
        
    }
    
    ///
    /// Tests computing the common prefix of a Zip sequence.
    ///
    
    func testZipPrefix() {
        
        let array1 = [0,0,0,0,1,2,3,4,5]
        let array2 = [0,0,0,1,2,3,4,5,6]
        
        let zipCommonPrefixLength = zip(array1, array2).commonPrefixLength
        XCTAssertEqual(zipCommonPrefixLength, 3)
        
    }
    
    ///
    /// Tests computing the XOR of two messages with the same length.
    ///
    
    func testSameLength() {

        let bytes: [UInt8] = [0x47,0x2a,0xff,0x7d,0x65]
        let key: [UInt8] = [0x55,0x8f,0x9a,0x31,0xac]
    
        let expectedBytes: [UInt8] = [0x12, 0xa5, 0x65, 0x4c, 0xc9]
        let result = bytes.xor(key: key)
        
        XCTAssertEqual(result, expectedBytes)
        XCTAssertEqual(result.xor(key: key), bytes)
        
    }
    
    ///
    /// Tests computing the XOR of two messages with the first being smaller that the second.
    ///
    
    func testSmallerMessage() {
    
        let bytes: [UInt8] = [0x47,0x2a,0xff,0x7d,0x65]
        let key: [UInt8] = [0x55,0x8f,0x9a,0x31,0xac,0x18,0x8d,0x4a,0x35]
        
        let expectedBytes: [UInt8] = [0x55,0x8f,0x9a,0x31,0xeb,0x32,0x72,0x37,0x50]
        let result = bytes.xor(key: key)
        
        XCTAssertEqual(result, expectedBytes)
        XCTAssertEqual(result.xor(key: key), bytes)
        
    }
    
    ///
    /// Tests computing the XOR of two messages with the first being longer that the second.
    ///
    
    func testBiggerMessage() {
        
        let bytes: [UInt8] = [0x47,0x2a,0xff,0x7d,0x65,0x18,0x8d,0x4a,0x35]
        let key: [UInt8] = [0x55,0x8f,0x9a,0x31,0xac]
        
        let expectedBytes: [UInt8] = [0x47,0x2a,0xff,0x7d,0x30,0x97,0x17,0x7b,0x99]
        let result = bytes.xor(key: key)
        
        XCTAssertEqual(result, expectedBytes)
        XCTAssertEqual(result.xor(key: key), bytes)
        
    }

    // MARK: - Convenience
    
}

// MARK: - Linux Support

extension XORTests {
    
    static var allTests : [(String, (XORTests) -> () throws -> Void)] {
        return [
            ("testAddingPadding", testAddingPadding),
            ("testZipPrefix", testZipPrefix),
            ("testSameLength", testSameLength),
            ("testSmallerMessage", testSmallerMessage),
            ("testBiggerMessage", testBiggerMessage)
        ]
    }
    
}

