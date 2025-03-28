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
    
    @MainActor
    func testResponse() async throws {
        let vc = getVC()
        await delay(2.0, vc: vc)
        XCTAssertEqual(vc.post?.userID, 10000)
    }
}
