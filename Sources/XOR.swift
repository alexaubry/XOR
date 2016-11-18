/*
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   XOR.swift
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

import Foundation

// MARK: - Core

extension Array where Element: Integer {
    
    ///
    /// Computes the eXclusive OR of the receiver and the specified key.
    ///
    /// **Implementation details:**
    ///
    /// - If a component (either the receiver or the key) has a smaller length that the other component, padding will be added to it. This allows you to have a key bigger than the message, or vice-versa.
    /// - Any common prefix between the receiver and the key will be stripped, in order to remove any leading `0`s.
    ///
    /// For more informations on the XOR algorithm ➡️ [Wikipedia](https://en.wikipedia.org/wiki/Exclusive_or)
    ///
    /// - parameter key: The key to use to compute the XOR.
    ///
    /// - returns: The bytes composing the XOR sequence.
    ///
    
    public func xor(key: [Element]) -> [Element] {
        
        let input = [Element](self)
        
        // Pad the smallest sequence if needed
        
        let biggestCount = Swift.max(input.count, key.count)
        
        let message1 = input.addingPadding(to: biggestCount)
        let message2 = key.addingPadding(to: biggestCount)
        
        // Compute the XOR
        
        let zipSequence = zip(message1, message2)
        let commonPrefixLength = zipSequence.commonPrefixLength
        
        return zipSequence.dropFirst(commonPrefixLength).map { $0 ^ $1 }
        
    }
    
    ///
    /// Adds leading padding zeros to the receiver in order to assign it a particular size.
    ///
    /// - parameter count: The number of elements of the array after padding is applied.
    ///
    /// - returns: An array composed of the original array plus optional leading padding zeros, which has the size specified when calling the method.
    ///
    /// - note: If `count <= self.count` the receiver will be left intact.
    ///
    
    internal func addingPadding(to count: Int) -> [Element] {
        
        let countsDifference = count - self.count
        let paddingZerosCount = countsDifference >= 0 ? countsDifference : 0
        
        var paddedArray = [Element](repeating: 0, count: paddingZerosCount)
        paddedArray.append(contentsOf: self)
        
        return paddedArray
        
    }

}

// MARK: - Utilities

extension Zip2Sequence where Sequence1.Iterator.Element == Sequence2.Iterator.Element, Sequence1.Iterator.Element: Equatable, Sequence2.Iterator.Element: Equatable {
    
    ///
    /// Determines the length of the common prefix of the two sequences.
    ///
    
    internal var commonPrefixLength: Int {
        var length = 0
        
        for sequence in self {
            guard sequence.0 == sequence.1 else { break }
            length += 1
        }
        
        return length
        
    }
    
}
