//
//  File.swift
//  
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import UIKit

public protocol XUIView {
    var onClick: (() -> Void)? { get set }
}

extension UIView {
    @objc fileprivate func invokeOnClick() {
        if let view = self as? any XUIView,
           let onClick = view.onClick
        {
            onClick()
        }
    }
}

extension XUIView where Self: UIView {
    public init(frame: CGRect) {
        self = Self.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(invokeOnClick)))
    }
}
