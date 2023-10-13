//
//  UINavigationController+.swift
//
//
//  Created by Ji-Hwan Kim on 10/13/23.
//

import Foundation
import UIKit
import SwiftQuartzCoreExtension

open class XUINavigationController: UINavigationController {
    public var performSwipeToBack = true
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
    }
}

extension XUINavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        performSwipeToBack && viewControllers.count > 1
    }
}

extension XUINavigationController {
    @discardableResult
    public func pop(
        animated: Bool = true,
        completion: @escaping () -> Void = {}
    ) -> XUIViewController? {
        CATransaction.run(completion: completion, action: {
            self.popViewController(animated: animated) as! XUIViewController
        })
    }
    
    @discardableResult
    public func popAll(
        animated: Bool = true,
        completion: @escaping () -> Void = {}
    ) -> [XUIViewController]? {
        CATransaction.run(completion: completion, action: {
            self.popToRootViewController(animated: animated)?.map { $0 as! XUIViewController }
        })
    }
    
    public func push(
        viewController: XUIViewController,
        animated: Bool = true,
        completion: @escaping () -> Void = {}
    ) {
        CATransaction.run(completion: completion, action: {
            self.pushViewController(viewController, animated: animated)
        })
    }
}

extension XUINavigationController {
    @discardableResult
    public func navigate<ViewController: XUIViewController>(
        viewController _: ViewController.Type, // unused
        storyboard: String,
        identifier: String,
        animated: Bool = true,
        arguments: [String : Any]? = nil
    ) -> ViewController {
        let viewController = UIStoryboard(name: storyboard, bundle: .main).instantiateViewController(withIdentifier: identifier) as! ViewController
        viewController.arguments = arguments ?? [:]
        push(viewController: viewController)
        
        return viewController
    }
    
    @discardableResult
    public func replace<ViewController: XUIViewController>(
        viewController _: ViewController.Type, // unused
        storyboard: String,
        identifier: String,
        animated: Bool = true,
        arguments: [String : Any]? = nil
    ) -> ViewController {
        let viewController = UIStoryboard(name: storyboard, bundle: .main).instantiateViewController(withIdentifier: identifier) as! ViewController
        viewController.arguments = arguments ?? [:]
        pop(animated: false, completion: {
            self.pushViewController(viewController, animated: animated)
        })
        
        return viewController
    }
}
