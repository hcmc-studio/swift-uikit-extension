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

extension UINavigationController {
    public func disableSwipeToBack() {
        if let self = self as? XUINavigationController {
            self.performSwipeToBack = false
        }
    }
    
    public func enableSwipeToBack() {
        if let self = self as? XUINavigationController {
            self.performSwipeToBack = true
        }
    }
}

extension UINavigationController {
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
        viewController: UIViewController,
        animated: Bool = true,
        completion: @escaping () -> Void = {}
    ) {
        CATransaction.run(completion: completion, action: {
            self.pushViewController(viewController, animated: animated)
        })
    }
}

extension UINavigationController {
    @discardableResult
    public func navigate(
        initialViewContrrollerStoryboard storyboard: String,
        animated: Bool = true
    ) -> UIViewController {
        guard let viewController = UIStoryboard(name: storyboard, bundle: .main).instantiateInitialViewController() else {
            fatalError("Initial view controller is not found in storyboard `\(storyboard)`")
        }
        
        push(viewController: viewController)
        
        return viewController
    }
    
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
    public func replace(
        initialViewControllerStoryboard storyboard: String,
        animated: Bool = true
    ) -> UIViewController {
        guard let viewController = UIStoryboard(name: storyboard, bundle: .main).instantiateInitialViewController() else {
            fatalError("Initial view controller is not found in storyboard `\(storyboard)`")
        }
        
        pop(animated: false, completion: {
            self.pushViewController(viewController, animated: animated)
        })
        
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
