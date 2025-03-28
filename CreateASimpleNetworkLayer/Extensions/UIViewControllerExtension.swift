//
//  UIViewControllerExtension.swift
//  CreateASimpleNetworkLayer
//
//  Created by Pooyan J on 3/28/25.
//

import UIKit

extension UIViewController {
    
    enum StoryboardName: String {
        case main = "Main"
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate(from storyboardName: StoryboardName = .main) -> Self {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
