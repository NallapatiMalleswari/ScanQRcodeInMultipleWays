//
//  ViewAnimations.swift
//  DhyanaGenric
//
//  Created by Hari Keerthipati on 03/07/18.
//  Copyright © 2018 AVANTARI. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func shake(completion: (() -> Swift.Void)? = nil)
    {
        let animation =  CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 8
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 10.0, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 10.0, y: center.y))
        layer.add(animation, forKey: "position")
    }
    
    func springAnimationForButton(){
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1.0,
                       options: .allowUserInteraction,
                       animations: {
                        self.transform = .identity
        },
                       completion: nil)
    }
}
