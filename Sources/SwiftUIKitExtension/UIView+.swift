//
//  File.swift
//
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import UIKit

open class XUIView: UIView, UIViewExtension {
    public var onClick: (() -> Void)? = nil
}

public protocol UIViewExtension {
    var onClick: (() -> Void)? { get set }
}

extension UIView {
    @objc func invokeOnClick() {
        if let view = self as? any UIViewExtension,
           let onClick = view.onClick
        {
            onClick()
        }
    }
}

extension UIViewExtension where Self: UIView {
    public init() {
        self = Self.init()
        addOnClickRecognizer()
    }
    
    public init?(coder: NSCoder) {
        if let view = Self.init(coder: coder) {
            self = view
            addOnClickRecognizer()
        } else {
            return nil
        }
    }
    
    public init(frame: CGRect) {
        self = Self.init(frame: frame)
        addOnClickRecognizer()
    }
    
    private func addOnClickRecognizer() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(invokeOnClick)))
    }
}
