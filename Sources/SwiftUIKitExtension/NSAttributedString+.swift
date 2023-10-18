//
//  NSAttributedString+.swift
//
//
//  Created by Ji-Hwan Kim on 10/13/23.
//

import Foundation
import UIKit

extension NSAttributedString {
    public convenience init(
        _ string: String,
        font: UIFont,
        letterSpacing: CGFloat = -0.3,
        foregroundColor: UIColor = .label,
        underlineColor: UIColor = .label,
        underlineStyle: NSUnderlineStyle = [],
        lineSpacing: CGFloat = 0,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        alignment: NSTextAlignment = .justified,
        bullet: String = "",
        indentation: CGFloat = 0
    ) {
        let string = (bullet.isEmpty) ? string : string.split(separator: "\n").map { "\(bullet) \($0)" }.joined(separator: "\n")
        self.init(
            string: string,
            attributes: [
                .font: font,
                .kern: letterSpacing,
                .foregroundColor: foregroundColor,
                .underlineColor: underlineColor,
                .underlineStyle: underlineStyle.rawValue,
                .paragraphStyle: NSMutableParagraphStyle(
                    lineSpacing: lineSpacing,
                    lineBreakMode: lineBreakMode,
                    alignment: alignment,
                    headIndent: indentation
                )
            ]
        )
    }
}

extension NSAttributedString {
    public class Builder {
        private var attributed: NSMutableAttributedString
        
        init() {
            self.attributed = .init()
        }
        
        init(attributed: NSMutableAttributedString) {
            self.attributed = attributed
        }
    }
}

extension NSAttributedString.Builder {
    public func append(_ attr: NSAttributedString) -> NSAttributedString.Builder {
        attributed.append(attr)
        return self
    }
    
    public func build() -> NSAttributedString {
        attributed
    }
}
