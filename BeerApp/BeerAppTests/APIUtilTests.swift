//
//  APIUtilTests.swift
//  BeerAppTests
//
//  Created by Dillon Massey on 20/08/2022.
//

import Foundation
import XCTest

class APIUtilTests: XCTestCase {
    
    func testInvalidAPIURL() {
        // Arrange
        let expectationNil = XCTestExpectation(description: "Data should be nil")
        let expectationCompletion = XCTestExpectation(description: "Completion block should be entered")
        let string = "InvalidUrl"
        let url = URL(string: string)
        
        // Act
        APIUtils.get(url: url) { data in
            expectationCompletion.fulfill()
            if data == nil { expectationNil.fulfill() }
        }
        
        // Assert
        wait(for: [expectationNil, expectationCompletion], timeout: 5)
    }
    
    func testNilAPIURL() {
        //Arrange
        let expectationNil = XCTestExpectation(description: "Data should be nil")
        let expectationCompletion = XCTestExpectation(description: "Completion block should be entered")

        // Act
        APIUtils.get(url: nil) { data in
            expectationCompletion.fulfill()
            if data == nil { expectationNil.fulfill() }
        }
        
        // Assert
        wait(for: [expectationNil, expectationCompletion], timeout: 5)
    }
    
}
