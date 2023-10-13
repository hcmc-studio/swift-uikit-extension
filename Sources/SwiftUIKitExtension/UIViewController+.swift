//
//  UIViewController+.swift
//
//
//  Created by Ji-Hwan Kim on 10/13/23.
//

import Foundation
import UIKit

open class XUIViewController: UIViewController {
    open var arguments: [String : Any]!
    private lazy var backgroundTapGestureRecognizer = {
        UITapGestureRecognizer(
            target: self,
            action: #selector(self.onBackgroundClick)
        )
    }()
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.addGestureRecognizer(backgroundTapGestureRecognizer)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        view.removeGestureRecognizer(backgroundTapGestureRecognizer)
    }
    
    @objc private func onBackgroundClick() {
        view.endEditing(true)
    }
}
