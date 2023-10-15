//
//  UIButton+.swift
//
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import UIKit

open class XUIButton: UIButton, UIViewExtension {
    public var onClick: (() -> Void)? = nil
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        addTouchUpInsideTarget()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        isUserInteractionEnabled = true
        addTouchUpInsideTarget()
    }
}

extension UIViewExtension where Self: UIButton {
    func addTouchUpInsideTarget() {
        addTarget(self, action: #selector(invokeOnClick), for: .touchUpInside)
    }
}
