//
//  XCTestCaseExtension.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import XCTest

extension XCTestCase {
    
    func delay(_ delay: Double, vc: UIViewController) async {
        let expectation = XCTestExpectation(description: "Wait for fetch")
        
        Task {
            await vc.viewDidLoad() // Call it asynchronously
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: delay)
    }
}
