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
    private func addTouchUpInsideTarget() {
        addTarget(self, action: #selector(invokeOnClick), for: .touchUpInside)
    }
}
