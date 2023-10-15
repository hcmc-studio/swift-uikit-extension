//
//  UIImageView+.swift
//
//
//  Created by Ji-Hwan Kim on 10/13/23.
//

import Foundation
import UIKit

open class XUIImageView: UIImageView, UIViewExtension {
    public var onClick: (() -> Void)? = nil
}
