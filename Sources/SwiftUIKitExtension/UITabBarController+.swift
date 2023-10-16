//
//  UITabBarController+.swift
//
//
//  Created by Ji-Hwan Kim on 10/16/23.
//

import Foundation
import UIKit

open class XUITabBarController: UITabBarController {
    public var performSwipeToBack = true
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension XUITabBarController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        performSwipeToBack && (navigationController?.viewControllers.count ?? 0) > 1
    }
}
