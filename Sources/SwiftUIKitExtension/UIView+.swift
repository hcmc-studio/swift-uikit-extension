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
    func addOnClickRecognizer() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(invokeOnClick)))
    }
}
