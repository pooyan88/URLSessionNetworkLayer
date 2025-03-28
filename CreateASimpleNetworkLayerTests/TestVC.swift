//
//  TestVC.swift
//  CreateASimpleNetworkLayerTests
//
//  Created by Pooyan J on 3/28/25.
//

import XCTest
@testable import CreateASimpleNetworkLayer

final class TestVC: XCTestCase {
    
    func getVC() -> ViewController {
        let vc = ViewController.instantiate(from: .main)
        vc.webService = TestWebService()
        return vc
    }
}

// Test Functions
extension TestVC {
    
    func testResponse() async throws {
        let vc = getVC()
        
        // Using expectation to wait for async call
        let expectation = XCTestExpectation(description: "Wait for fetchPostDetails")
        
        Task {
            await vc.viewDidLoad() // Call it asynchronously
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
        
        XCTAssertEqual(vc.post?.userID, 10000) // Matching mock data
    }
}
