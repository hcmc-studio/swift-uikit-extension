//
//  UIScrollView+.swift
//  
//
//  Created by Ji-Hwan Kim on 10/19/23.
//

import Foundation
import UIKit

extension UIScrollView {
    public var isBottom: Bool {
        contentOffset.y >= (contentSize.height - bounds.height)
    }
}
