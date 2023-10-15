//
//  UILabel+.swift
//
//
//  Created by Ji-Hwan Kim on 10/13/23.
//

import Foundation
import UIKit

open class XUILabel: UILabel, XUIView {
    public var onClick: (() -> Void)? = nil
}
