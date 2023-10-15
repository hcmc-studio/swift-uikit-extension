//
//  UILabel+.swift
//
//
//  Created by Ji-Hwan Kim on 10/13/23.
//

import Foundation
import UIKit

open class XUILabel: UILabel, UIViewExtension {
    public var onClick: (() -> Void)? = nil
}
