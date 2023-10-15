//
//  File.swift
//  
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import UIKit

open class XUITextView: UITextView, UIViewExtension {
    public var onClick: (() -> Void)? = nil
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        isUserInteractionEnabled = true
        addOnClickRecognizer()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        isUserInteractionEnabled = true
        addOnClickRecognizer()
    }
}
