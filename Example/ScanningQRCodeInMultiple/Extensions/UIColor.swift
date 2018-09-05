//
//  AppColor.swift
//  RadialSampleCode
//
//  Created by Hari Keerthipati on 06/07/18.
//  Copyright © 2018 Avantari Technologies. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    static var themeColor: UIColor  {
        return UIColor.color(red: 140, green: 219, blue: 251)
    }
    
    static var highlightColor: UIColor {
        return UIColor.color(red: 65, green: 254, blue: 245)
    }
    
    static var chartCircleColor: UIColor {
        return .white
    }
    
    static var chartColor: UIColor {
        return .white
    }
    
    static var lowRange: UIColor {
        return UIColor.color(red: 254, green: 131, blue: 131)
    }
    static var secondThemecolor: UIColor {
        return UIColor.color(red: 78, green: 198, blue: 247)
    }
    
    static func appRadialColors() -> [UIColor]
    {
        let color1 = UIColor.color(red: 4, green: 126, blue: 130)
        let color2 = UIColor.color(red: 15, green: 136, blue: 148)
        let color3 = UIColor.color(red: 5, green: 157, blue: 192)
        
        return [color1, color2, color3, .themeColor]
    }
    
    static func color(red: Int, green: Int, blue: Int, alpha: Double) -> UIColor
    {
        return UIColor(red: CGFloat(Double(red)/255.0), green: CGFloat(Double(green)/255.0), blue: CGFloat(Double(blue)/255.0), alpha: CGFloat(alpha))
    }
    
    static func color(red: Int, green: Int, blue: Int) -> UIColor
    {
        return UIColor.color(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
