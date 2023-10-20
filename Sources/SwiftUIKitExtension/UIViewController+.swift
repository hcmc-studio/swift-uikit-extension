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
    
    open func buildDialog() -> XUIViewController.DialogBuilder {
        .init(viewController: self)
    }
    
    @discardableResult
    open func showFallbackDialog(
        message: String = "오류가 발생했습니다.",
        shouldKillApplication: Bool = false,
        shouldGoBack: Bool = true,
        handler: @escaping (Dialog, UIAlertAction) -> Void = { dialog, action in }
    ) -> XUIViewController.Dialog {
        buildDialog()
            .set(title: "오류")
            .set(message: message)
            .set(action: .default, name: "확인", handler: handler)
            .build()
            .show()
    }
}

extension XUIViewController {
    public class DialogBuilder {
        let viewController: UIViewController
        var title: String? = nil
        var message: String? = nil
        var style: UIAlertController.Style = .alert
        var animateOnPresent = true
        var animateOnDismiss = true
        var actions = [UIAlertAction.Style : (String, (XUIViewController.Dialog, UIAlertAction) -> Void)]()
        
        public init(viewController: UIViewController) {
            self.viewController = viewController
        }
    }
}

extension XUIViewController.DialogBuilder {
    public func set(title: String?) -> XUIViewController.DialogBuilder {
        self.title = title
        return self
    }
    
    public func set(message: String?) -> XUIViewController.DialogBuilder {
        self.message = message
        return self
    }
    
    public func set(style: UIAlertController.Style) -> XUIViewController.DialogBuilder {
        self.style = style
        return self
    }
    
    public func set(
        action style: UIAlertAction.Style,
        name: String
    ) -> XUIViewController.DialogBuilder {
        set(
            action: style,
            name: name,
            handler: actions[style]?.1 ?? { dialog, action in dialog.dismiss() }
        )
    }
    
    public func set(
        action style: UIAlertAction.Style,
        name: String,
        handler: @escaping (XUIViewController.Dialog, UIAlertAction) -> Void
    ) -> XUIViewController.DialogBuilder {
        actions[style] = (name, handler)
        return self
    }
    
    public func set(animateOnPresent: Bool) -> XUIViewController.DialogBuilder {
        self.animateOnPresent = animateOnPresent
        return self
    }
    
    public func set(animateOnDismiss: Bool) -> XUIViewController.DialogBuilder {
        self.animateOnDismiss = animateOnDismiss
        return self
    }
    
    public func build() -> XUIViewController.Dialog {
        .init(builder: self)
    }
}

extension XUIViewController {
    public class Dialog {
        let builder: XUIViewController.DialogBuilder
        let animateOnPresent: Bool
        let animateOnDismiss: Bool
        let alertController: UIAlertController
        
        init(builder: XUIViewController.DialogBuilder) {
            self.builder = builder
            self.animateOnPresent = builder.animateOnPresent
            self.animateOnDismiss = builder.animateOnDismiss
            self.alertController = .init(
                title: builder.title,
                message: builder.message,
                preferredStyle: builder.style
            )
            
            for (style, (title, handler)) in builder.actions {
                alertController.addAction(.init(title: title, style: style, handler: { [weak self] action in
                    if let self = self {
                        handler(self, action)
                    }
                }))
            }
        }
    }
}

extension XUIViewController.Dialog {
    @discardableResult
    public func show() -> XUIViewController.Dialog {
        builder.viewController.present(alertController, animated: animateOnPresent)
        return self
    }
    
    @discardableResult
    public func dismiss() -> XUIViewController.Dialog {
        alertController.dismiss(animated: animateOnDismiss)
        return self
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

extension XUIViewControllerFetchDelegate {
    func onLoad(viewController: XUIViewController) {
        viewController.onLoadTask = Task<Void, any Error>.execute(
            priority: .high,
            withoutResult: fetchOnLoad,
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
            withoutResult: fetchOnAppear,
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

open class XUIListViewController: XUIViewController, UITableViewDelegate, UITableViewDataSource {
    public let activityIndicator = XUIActivityIndicatorView(style: .medium)
    public let tableView = XUITableView()
    public var tableSections = [any XUIListViewControllerTableSection]()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.alwaysBounceHorizontal = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        for tableSection in tableSections {
            tableView.register(tableSection.cell, forCellReuseIdentifier: tableSection.reuseIdentifier)
        }
        
        NSLayoutConstraint.activate(
            activityIndicator.center(equalTo: view),
            tableView.fit(equalTo: view)
        )
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Not Implemented: XUIListViewController.tableView(_:numberOfRowsInSection:)")
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Not Implemented: XUIListViewController.tableView(_:cellForRowAt:)")
    }
}

public protocol XUIListViewControllerTableSection {
    var cell: XUITableViewCell<Any>.Type { get }
    var reuseIdentifier: String { get }
}
