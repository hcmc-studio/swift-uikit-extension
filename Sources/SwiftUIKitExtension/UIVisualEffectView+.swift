//
//  UIVisualEffectView+.swift
//
//
//  Created by Ji-Hwan Kim on 10/22/23.
//

import Foundation
import UIKit

open class XUIVisualEffectView: UIVisualEffectView, UIViewExtension {
    public var onClick: (() -> Void)? = nil
    
    public override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        addOnClickRecognizer()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        addOnClickRecognizer()
    }
}
