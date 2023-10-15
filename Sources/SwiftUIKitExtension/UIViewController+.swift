//
//  UIViewController+.swift
//
//
//  Created by Ji-Hwan Kim on 10/13/23.
//

import Foundation
import UIKit

open class XUIViewController: UIViewController {
    open var arguments: [String : Any]!
    open var fetchDelegate: XUIViewControllerFetchDelegate? = nil
    
    private lazy var backgroundTapGestureRecognizer = {
        UITapGestureRecognizer(
            target: self,
            action: #selector(self.onBackgroundClick)
        )
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeFetchDelegate()
        if let fetchDelegate = fetchDelegate {
            Task {
                do {
                    try await fetchDelegate.fetchOnLoad()
                    await MainActor.run {
                        fetchDelegate.fetchOnLoadDidFinished(error: nil)
                        fetchDelegate.fetchOnLoadSucceed()
                    }
                } catch let error {
                    await MainActor.run {
                        fetchDelegate.fetchOnLoadDidFinished(error: error)
                        fetchDelegate.fetchOnLoadFailed(error: error)
                    }
                }
            }
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.addGestureRecognizer(backgroundTapGestureRecognizer)
        
        if let fetchDelegate = fetchDelegate {
            Task {
                do {
                    try await fetchDelegate.fetchOnAppear()
                    await MainActor.run {
                        fetchDelegate.fetchOnAppearDidFinished(error: nil)
                        fetchDelegate.fetchOnAppearSucceed()
                    }
                } catch let error {
                    await MainActor.run {
                        fetchDelegate.fetchOnAppearDidFinished(error: error)
                        fetchDelegate.fetchOnAppearFailed(error: error)
                    }
                }
            }
        }
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
}
