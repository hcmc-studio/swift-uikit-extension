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
            prepareView()
        }
        
        task = Task<Void, any Error>.execute(
            withoutResult: fetch,
            onReady: bindView
        )
    }
    
    open func prepareView() {}
    
    open func fetch() async throws {}
    
    open func bindView(error: Error?) {}
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        
        task?.cancel()
    }
}
