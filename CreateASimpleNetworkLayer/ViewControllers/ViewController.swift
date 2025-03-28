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
                let users = try await webService.fetchUsers()
                print("Users fetched: \(users)")
            } catch {
                print("Error occurred: \(error)")
            }
        }
    }
}

