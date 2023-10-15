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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addEditingChangedTarget()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        addEditingChangedTarget()
    }
    
    @objc func invokeOnTextChange() {
        onTextChange?()
    }
}

extension XUITextField {
    func addEditingChangedTarget() {
        isUserInteractionEnabled = true
        addTarget(self, action: #selector(invokeOnTextChange), for: .editingChanged)
    }
}
