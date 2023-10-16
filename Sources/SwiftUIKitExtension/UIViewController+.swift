//
//  UIViewController+.swift
//
//
//  Created by Ji-Hwan Kim on 10/13/23.
//

import Foundation
import UIKit
import SwiftConcurrencyExtension

open class XUIViewController: UIViewController {
    open var arguments: [String : Any]!
    open var fetchDelegate: XUIViewControllerFetchDelegate? = nil
    public fileprivate(set) var onLoadTask: Task<Void, any Error>? = nil
    public fileprivate(set) var onAppearTask: Task<Void, any Error>? = nil
    
    private lazy var backgroundTapGestureRecognizer = {
        UITapGestureRecognizer(
            target: self,
            action: #selector(self.onBackgroundClick)
        )
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeFetchDelegate()
        fetchDelegate?.onLoad(viewController: self)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.addGestureRecognizer(backgroundTapGestureRecognizer)
        fetchDelegate?.onAppear(viewController: self)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        view.removeGestureRecognizer(backgroundTapGestureRecognizer)
    }
    
    open func initializeFetchDelegate() {}
    
    @objc private func onBackgroundClick() {
        view.endEditing(true)
    }
}

public protocol XUIViewControllerFetchDelegate {
    func fetchOnLoad() async throws
    
    func fetchOnLoadDidFinished(error: Error?)
    
    func fetchOnLoadSucceed()
    
    func fetchOnLoadFailed(error: Error)
    
    func fetchOnAppear() async throws
    
    func fetchOnAppearDidFinished(error: Error?)
    
    func fetchOnAppearSucceed()
    
    func fetchOnAppearFailed(error: Error)
}

extension XUIViewControllerFetchDelegate {
    public func fetchOnLoad() async throws {}
    
    public func fetchOnLoadDidFinished(error: Error?) {}
    
    public func fetchOnLoadSucceed() {}
    
    public func fetchOnLoadFailed(error: Error) {}
    
    public func fetchOnAppear() async throws {}
    
    public func fetchOnAppearDidFinished(error: Error?) {}
    
    public func fetchOnAppearSucceed() {}
    
    public func fetchOnAppearFailed(error: Error) {}
    
    func onLoad(viewController: XUIViewController) {
        viewController.onLoadTask = Task<Void, any Error>.execute(
            priority: .high,
            fetch: fetchOnLoad,
            onSuccess: {
                viewController.onLoadTask = nil
                fetchOnLoadDidFinished(error: nil)
                fetchOnLoadSucceed()
            },
            onFailure: { error in
                viewController.onLoadTask = nil
                fetchOnLoadDidFinished(error: error)
                fetchOnLoadFailed(error: error)
            }
        )
    }
    
    func onAppear(viewController: XUIViewController) {
        viewController.onAppearTask = Task<Void, any Error>.execute(
            priority: .high,
            fetch: fetchOnAppear,
            onSuccess: {
                viewController.onAppearTask = nil
                fetchOnAppearDidFinished(error: nil)
                fetchOnAppearSucceed()
            },
            onFailure: { error in
                viewController.onAppearTask = nil
                fetchOnAppearDidFinished(error: error)
                fetchOnAppearFailed(error: error)
            }
        )
    }
}
