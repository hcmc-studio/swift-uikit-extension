//
//  NSLayoutConstraint+.swift
//
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    public class func activate(constraints arrays: [NSLayoutConstraint]...) {
        activate(arrays.reduce([], +))
    }
}

extension UIView {
    public func center(
        equalTo view: UIView,
        x: CGFloat = .zero,
        y: CGFloat = .zero
    ) -> [NSLayoutConstraint] {
        [
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: x),
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: y)
        ]
    }
    
    public func fit(
        equalTo view: UIView,
        top: CGFloat? = .zero,
        leading: CGFloat? = .zero,
        trailing: CGFloat? = .zero,
        bottom: CGFloat? = .zero
    ) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        if let top = top {
            constraints.append(topAnchor.constraint(equalTo: view.topAnchor, constant: top))
        }
        if let leading = leading {
            constraints.append(leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading))
        }
        if let trailing = trailing {
            constraints.append(trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing))
        }
        if let bottom = bottom {
            constraints.append(bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom))
        }
        
        return constraints
    }
}
