//
//  File.swift
//  
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import UIKit

open class XUITextField: UITextField, UIViewExtension {
    public var onClick: (() -> Void)? = nil
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        addOnClickRecognizer()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        isUserInteractionEnabled = true
        addOnClickRecognizer()
    }
}
