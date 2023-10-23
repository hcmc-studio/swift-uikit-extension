//
//  UITableViewCell+.swift
//
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import UIKit

open class XUITableViewCell<Delegate>: UITableViewCell, UIViewExtension {
    public var onClick: (() -> Void)? = nil
    public var indexPath: IndexPath!
    public var delegate: Delegate!
    open var padding: UIEdgeInsets { .zero }
    open var contentContainer = XUIView()
    
    private var task: Task<Void, any Error>? = nil
    private var isViewPresent = false
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addOnClickRecognizer()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addOnClickRecognizer()
    }
    
    func bind() {
        if !isViewPresent {
            isViewPresent = true
            prepareContainer()
            prepareView()
        }
        
        task = Task<Void, any Error>.execute(
            withoutResult: fetch,
            onReady: bindView
        )
    }
    
    private func prepareContainer() {
        contentView.addSubview(contentContainer)
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(contentContainer.fit(
            equalTo: contentView,
            top: padding.top,
            leading: padding.left,
            trailing: padding.right,
            bottom: padding.bottom
        ))
    }
    
    /// View를 초기화하는 블록입니다. 1회만 실행됩니다.
    open func prepareView() {}
    
    open func fetch() async throws {}
    
    /// View의 내용을 초기화하는 블록입니다. 매 bind마다 실행됩니다.
    open func bindView(error: Error?) {}
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        
        task?.cancel()
    }
}
