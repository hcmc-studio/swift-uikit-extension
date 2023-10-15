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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addOnClickRecognizer()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        addOnClickRecognizer()
    }
}
