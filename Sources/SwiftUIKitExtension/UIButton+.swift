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
        addTouchUpInsideTarget()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        addTouchUpInsideTarget()
    }
}

extension UIViewExtension where Self: UIButton {
    func addTouchUpInsideTarget() {
        isUserInteractionEnabled = true
        addTarget(self, action: #selector(invokeOnClick), for: .touchUpInside)
    }
}

@available(iOS 15.0, *)
extension UIButton.Configuration {
    public static func icon(_ icon: UIImage) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.borderless()
        configuration.imagePadding = 0
        configuration.contentInsets = .zero
        configuration.image = icon.withRenderingMode(.alwaysTemplate)
        
        return configuration
    }
    
    public static func icon(system name: String) -> UIButton.Configuration {
        icon(.init(systemName: name)!)
    }
}
