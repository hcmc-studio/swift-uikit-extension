//
//  UIButton+.swift
//
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import UIKit

open class XUIButton: UIView, UIViewExtension {
    public var onClick: (() -> Void)? = nil
}

extension UIViewExtension where Self: UIButton {
    public init() {
        self = Self.init()
        addTouchUpInsideTarget()
    }
    
    public init(frame: CGRect) {
        self = Self.init(frame: frame)
        addTouchUpInsideTarget()
    }
    
    public init(type: UIButton.ButtonType) {
        self.init(type: type)
        addTouchUpInsideTarget()
    }
    
    public init(frame: CGRect, primaryAction: UIAction?) {
        self.init(frame: frame, primaryAction: primaryAction)
        addTouchUpInsideTarget()
    }
    
    private func addTouchUpInsideTarget() {
        addTarget(self, action: #selector(invokeOnClick), for: .touchUpInside)
    }
}
