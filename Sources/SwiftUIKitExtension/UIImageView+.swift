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
    
    public override init(image: UIImage?) {
        super.init(image: image)
        isUserInteractionEnabled = true
        addOnClickRecognizer()
    }
    
    public override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        isUserInteractionEnabled = true
        addOnClickRecognizer()
    }
}
