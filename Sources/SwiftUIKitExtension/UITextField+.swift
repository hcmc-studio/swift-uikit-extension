//
//  File.swift
//  
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import UIKit

open class XUITextField: UITextField, UIViewExtension {
    public var onClick: (() -> Void)? = nil
    public var onTextChange: (() -> Void)? = nil
    public var padding: UIEdgeInsets = .zero
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addEditingChangedTarget()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        addEditingChangedTarget()
    }
    
    @objc open func invokeOnTextChange() {
        onTextChange?()
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}

extension XUITextField {
    func addEditingChangedTarget() {
        isUserInteractionEnabled = true
        addTarget(self, action: #selector(invokeOnTextChange), for: .editingChanged)
    }
}
