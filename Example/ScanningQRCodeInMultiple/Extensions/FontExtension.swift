//
//  FontExtension.swift
//  DhyanaGenric
//
//  Created by Hari Keerthipati on 20/06/18.
//  Copyright © 2018 AVANTARI. All rights reserved.
//

import Foundation
import UIKit

extension UIFont{
    
    static var tutorialFont: UIFont
    {
        let font =  appFont(with: 18)
        return font
    }
    
    static var appFont: UIFont
    {
        let font =  appFont(with: 18)
        return font
    }
    
    static var boldFont: UIFont
    {
        let font =  boldFont(with: 18)
        return font
    }
    
    static func ultraLightFont(with size: Int) -> UIFont
    {
        let font = UIFont(name: "AvenirNext-UltraLight", size: CGFloat(size))
        return font!
    }
    
    static func appFont(with size: Int) -> UIFont
    {
        let font =  UIFont(name: "AvenirNext-Regular", size: CGFloat(size))
        return font!
    }
    
    static func boldFont(with size: Int) -> UIFont
    {
        let font =  UIFont(name: "AvenirNext-DemiBold", size: CGFloat(size))
        return font!
    }
    static func mediumFont(with size:Int) -> UIFont{
        let font = UIFont(name: "AvenirNext-Medium", size: CGFloat(size))
        return font!
    }
}
