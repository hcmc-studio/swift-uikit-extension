//
//  UITableViewCell+.swift
//
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import UIKit

open class XUITableViewCell: UITableViewCell, UIViewExtension {
    public var onClick: (() -> Void)? = nil
    public let contentContainer = XUIView()
    private var task: Task<Void, any Error>? = nil
    private var isViewPresent = false
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addOnClickRecognizer()
        prepareContainer()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        addOnClickRecognizer()
        prepareContainer()
    }
    
    private func prepareContainer() {
        contentView.addSubview(contentContainer)
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(contentContainer.fit(equalTo: contentView))
    }
    
    func bind() {
        if !isViewPresent {
            prepareView()
        }
        
        task = Task<Void, any Error>.execute(
            withoutResult: fetch,
            onReady: bindView
        )
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
