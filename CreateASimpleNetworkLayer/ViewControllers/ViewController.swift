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
        // Do any additional setup after loading the view.
        Task { @MainActor in
            do {
                _ = try await webService.fetchUsers()
            } catch {
                print(error)
            }
        }
    }


}

