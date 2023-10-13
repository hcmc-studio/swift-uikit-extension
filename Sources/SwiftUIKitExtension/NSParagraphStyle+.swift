//
//  NSParagraphStyle+.swift
//
//
//  Created by Ji-Hwan Kim on 10/13/23.
//

import Foundation
import UIKit

public extension NSMutableParagraphStyle {
    convenience init(
        lineSpacing: CGFloat = 0,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        alignment: NSTextAlignment = .justified,
        headIndent: CGFloat = 0
    ) {
        self.init()
        self.lineSpacing = lineSpacing
        self.lineBreakMode = lineBreakMode
        self.alignment = alignment
        self.headIndent = headIndent
    }
}
