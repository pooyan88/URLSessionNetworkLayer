//
//  ViewController.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import UIKit

class ViewController: UIViewController {
    
    let webService = WebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task { @MainActor in
            do {
                // Fetch users using the WebService
                let post = try await webService.fetchPostDetails(id: 1)
                print("post fetched: \(post)")
            } catch {
                print("Error occurred: \(error)")
            }
        }
    }
}

