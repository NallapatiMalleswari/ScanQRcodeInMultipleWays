//
//  UILabel+BoldText.swift
//  DhyanaNew
//
//  Created by Hari Keerthipati on 09/08/18.
//  Copyright © 2018 Avantari Technologies. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func boldRange(_ range: Range<String.Index>) {
        if let text = self.attributedText {
            let attr = NSMutableAttributedString(attributedString: text)
            let start = text.string.distance(from: text.string.startIndex, to: range.lowerBound)
            let length = text.string.distance(from: range.lowerBound, to: range.upperBound)
            attr.addAttributes([NSAttributedStringKey.font: UIFont.mediumFont(with: Int(self.font.pointSize))], range: NSMakeRange(start, length))
            self.attributedText = attr
        }
    }
    
    func makeDhyanaBold()
    {
        let dhyanaText = "dhyana"
        if let text = self.attributedText {
            var range = text.string.range(of: dhyanaText)
            let attr = NSMutableAttributedString(attributedString: text)
            while range != nil {
                let start = text.string.distance(from: text.string.startIndex, to: range!.lowerBound)
                let length = text.string.distance(from: range!.lowerBound, to: range!.upperBound)
                var nsRange = NSMakeRange(start, length)
                let font = attr.attribute(NSAttributedStringKey.font, at: start, effectiveRange: &nsRange) as! UIFont
                if !font.fontDescriptor.symbolicTraits.contains(.traitBold) {
                    break
                }
                range = text.string.range(of: dhyanaText, options: NSString.CompareOptions.literal, range: range!.upperBound..<text.string.endIndex, locale: nil)
            }
            if let r = range {
                boldRange(r)
            }
        }
    }
    
    func boldSubstring(_ substr: String) {
        if let text = self.attributedText {
            var range = text.string.range(of: substr)
            let attr = NSMutableAttributedString(attributedString: text)
            while range != nil {
                let start = text.string.distance(from: text.string.startIndex, to: range!.lowerBound)
                let length = text.string.distance(from: range!.lowerBound, to: range!.upperBound)
                var nsRange = NSMakeRange(start, length)
                let font = attr.attribute(NSAttributedStringKey.font, at: start, effectiveRange: &nsRange) as! UIFont
                if !font.fontDescriptor.symbolicTraits.contains(.traitBold) {
                    break
                }
                range = text.string.range(of: substr, options: NSString.CompareOptions.literal, range: range!.upperBound..<text.string.endIndex, locale: nil)
            }
            if let r = range {
                boldRange(r)
            }
        }
    }
}
