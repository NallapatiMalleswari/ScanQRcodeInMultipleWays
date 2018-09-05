//
//  Extentions.swift
//  DhyanaGenric
//    
//  Created by AVANTARI on 17/11/17.
//  Copyright © 2017 AVANTARI. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element: Numeric {
    /// Returns the total sum of all elements in the array
    var total: Element { return reduce(0, +) }
}

extension Array where Element: BinaryInteger {
    /// Returns the average of all elements in the array
    var average: Int {
        return isEmpty ? 0 : Int(total) / count
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension NSData {
    
    var hexString: String? {
        let buf   = bytes.assumingMemoryBound(to: UInt8.self)
        let charA = UInt8(UnicodeScalar("a").value)
        let char0 = UInt8(UnicodeScalar("0").value)
        
        func itoh(_ value: UInt8) -> UInt8 {
            return (value > 9) ? (charA + value - 10) : (char0 + value)
        }
        
        let hexLen = length * 2
        let ptr    = UnsafeMutablePointer<UInt8>.allocate(capacity: hexLen)
        
        for i in 0 ..< length {
            ptr[i*2] = itoh((buf[i] >> 4) & 0xF)
            ptr[i*2+1] = itoh(buf[i] & 0xF)
        }
        
        return String(bytesNoCopy: ptr, length: hexLen, encoding: .utf8, freeWhenDone: true)
    }
}
extension NSData {
    var uint8: [UInt8] {
        get {
            var number: UInt8 = 0
            self.getBytes(&number, length: MemoryLayout<UInt8>.size)
            return [number]
        }
    }
}
extension String {
    var utfArry: [UInt8] {
        return Array(utf8)
    }
}

extension String {
    var hexa2Bytes: [UInt8] {
        let hexa = Array(self)
        return stride(from: 0, to: self.count, by: 2).compactMap { UInt8(String(hexa[$0..<$0.advanced(by: 2)]), radix: 16) }
    }
}
extension UInt32 {
    var asByteArray: [UInt8] {
        return [0, 8, 16, 24]
            .map { UInt8(self >> $0 & 0x000000FF) }
    }
}
extension Array {
    
    func chunked(by distance: Int) -> [[Element]] {
        let indicesSequence = stride(from: self.startIndex, to: self.endIndex, by: distance)
        let array: [[Element]] = indicesSequence.map {
            let rangeEndIndex = $0.advanced(by: distance) > self.endIndex ? self.endIndex : $0.advanced(by: distance)
            //let rangeEndIndex = self.index($0, offsetBy: distance, limitedBy: self.endIndex) ?? self.endIndex // also works
            return Array(self[$0 ..< rangeEndIndex])
        }
        return array
    }
    
}
extension String {
    var utf8Array: [UInt8] {
        return Array(utf8)
    }
}
extension Int {
    func pad(left: Int, right: Int) -> [Int] {
        let leftSide = [Int](repeating: 0, count: left)
        //let rightSide = [Int](count: right, repeatedValue: 0)
        return leftSide
    }
}
extension String {
    func leftPadding(toLength: Int, withPad: String = " ") -> String {
        guard toLength > self.count else { return self }
        let padding = String(repeating: withPad, count: toLength - self.count)
        return padding + self
    }
    
    func rightPadding(toLength: Int, withPad: String = " ") -> String {
        guard toLength > self.count else {return self}
        let padding = String(repeating: withPad, count: toLength - self.count)
        return self + padding
    }
}

extension UInt8 {
    var character: Character {
        return Character(UnicodeScalar(self))
    }
}

extension UILabel {

    func setTextWithAnimation(text: String, completion: @escaping ()->())
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0.0
        }) { (finished) in
            self.text = text
            completion()
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 1.0
            })
        }
    }
    
    func setTextWithAnimation(text: String)
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0.0
        }) { (finished) in
            self.text = text
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 1.0
            })
        }
    }
}

extension Array
{
    func setAlphaWithAnimation(alpha: CGFloat) {
        
        UIView.animate(withDuration: 0.5) {
            for index in 0..<self.count {
                if let view = self[index] as? UIView
                {
                    view.alpha = alpha
                }
            }
        }
    }
}

extension CAShapeLayer {
    func pauseAnimation(){
        let pausedTime  = self.convertTime(CACurrentMediaTime(), from: nil)
        self.speed      = 0.0
        self.timeOffset = pausedTime
    }
    
    func resumeAnimation(){
        let pausedTime     = self.timeOffset
        self.speed         = 1.0
        self.timeOffset    = 0.0
        self.beginTime     = 0.0
        let timeSincePause = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.beginTime     = timeSincePause
    }
}

extension UIView {
    
    func makeRoundCorners(width: CGFloat){
        self.layer.cornerRadius = 0.5 * width
        self.clipsToBounds      = true
    }
    
    func setAlphaWithAnimation(for bool: Bool)
    {
        let alpha = bool ? 1.0 : 0.0
        UIView.animate(withDuration: 0.5) {
            self.alpha = CGFloat(alpha)
        }
    }
    
    func setAlphaWithAnimation(alpha: Double)
    {
        UIView.animate(withDuration: 0.5) {
            self.alpha = CGFloat(alpha)
        }
    }
    
    func removeFromSuperViewWithAnimation()
    {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    func addSubViewWithAnimations(subView: UIView)
    {
        subView.alpha = 0.0
        self.addSubview(subView)
        UIView.animate(withDuration: 0.5) {
            subView.alpha = 1.0
        }
    }
    
    func addSubViewWithAnimations(subView: UIView, completion: @escaping ()->())
    {
        subView.alpha = 0.0
        self.addSubview(subView)
        UIView.animate(withDuration: 0.5, animations: {
            subView.alpha = 1.0
        }) { (finished) in
            completion()
        }
    }
    
    func addShadow() {
        self.layer.masksToBounds      = false
        self.layer.shadowColor        = UIColor.black.cgColor
        self.layer.shadowOpacity      = 0.3
        self.layer.shadowOffset       = CGSize(width: 0, height: 1)
        self.layer.shadowRadius       = 3.0
        self.layer.shadowPath         = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize    = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func removeShadow() {
        self.layer.masksToBounds      = false
        self.layer.shadowColor        = UIColor.black.cgColor
        self.layer.shadowOpacity      = 0.0
        self.layer.shadowOffset       = CGSize(width: 0, height: 1)
        self.layer.shadowRadius       = 3.0
        self.layer.shadowPath         = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize    = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addShadowToRoundButton(_ radius: CGFloat? = nil) {
        self.layer.cornerRadius  = radius ?? self.frame.size.width / 2
        self.layer.shadowColor   = UIColor.black.cgColor
        self.layer.shadowOffset  = CGSize(width: 0, height: 1)
        self.layer.shadowRadius  = 3.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }
    func addCornerRadious(_ radius: CGFloat? = nil){
        self.layer.cornerRadius = radius ?? self.frame.size.width/2
    }
}

extension UIButton {
    func changeImageAnimated(image: UIImage?) {
        guard let imageView = self.imageView, let currentImage = imageView.image, let newImage = image else {
            return
        }
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.setImage(newImage, for: UIControlState.normal)
        }
        let crossFade: CABasicAnimation = CABasicAnimation(keyPath: "contents")
        crossFade.duration              = 0.3
        crossFade.fromValue             = currentImage.cgImage
        crossFade.toValue               = newImage.cgImage
        crossFade.isRemovedOnCompletion = false
        crossFade.fillMode              = kCAFillModeForwards
        imageView.layer.add(crossFade, forKey: "animateContents")
        CATransaction.commit()
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Bold", size: 14)!]
        let boldString                          = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        return self
    }
    
    @discardableResult func italic(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Italic", size: 14)!]
        let italicString                        = NSMutableAttributedString(string:text, attributes: attrs)
        append(italicString)
        return self
    }
    
    @discardableResult func smaller(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Regular", size: 26)!]
        let italicString                        = NSMutableAttributedString(string:text, attributes: attrs)
        append(italicString)
        return self
    }
    
    @discardableResult func smallerTimeLabel(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Regular", size: 15)!]
        let italicString                        = NSMutableAttributedString(string:text, attributes: attrs)
        append(italicString)
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        return self
    }
}

extension UIColor{
    convenience init(r: CGFloat,g: CGFloat,b: CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970).rounded())
        //RESOLVED CRASH HERE
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}

extension NSData {
    var u8:UInt8 {
        assert(self.length >= 1)
        var byte:UInt8 = 0x00
        self.getBytes(&byte, length: 1)
        return byte
    }
    var u16:UInt16 {
        assert(self.length >= 2)
        var word:UInt16 = 0x0000
        self.getBytes(&word, length: 2)
        return word
    }
    
    var u32:UInt32 {
        assert(self.length >= 4)
        var u32:UInt32 = 0x00000000
        self.getBytes(&u32, length: 4)
        return u32
    }
    
    var u64:UInt64{
        assert(self.length >= 8)
        var u64:UInt64 =  0x00000000000000000
        self.getBytes(&u64, length: 8)
        return u64
        
    }
    
    var float32:Float32{
        //0x2A
        //0x3fc00000
        assert(self.length >= 4)
        var float32:Float32 = 0x3fc00000
        self.getBytes(&float32, length: 4)
        return float32
    }
    var u8s:[UInt8] { // Array of UInt8, Swift byte array basically
        var buffer:[UInt8] = [UInt8](repeating: 0, count: self.length)
        self.getBytes(&buffer, length: self.length)
        return buffer
    }
    
    var utf8:String? {
        return String(data: self as Data, encoding: String.Encoding.utf8)
    }
}
extension FileManager {
    func fileSizeAtPath(path: String) -> Int64 {
        do {
            let fileAttributes = try attributesOfItem(atPath: path)
            let fileSizeNumber = fileAttributes[FileAttributeKey.size]
            let fileSize       = (fileSizeNumber as AnyObject).longLongValue
            return fileSize!
        } catch {
            print("error reading filesize, NSFileManager extension fileSizeAtPath")
            return 0
        }
    }
    
    func folderSizeAtPath(path: String) -> Int64 {
        
        var size : Int64 = 0
        do {
            let files = try subpathsOfDirectory(atPath: path)
            for i in 0 ..< files.count {
                size += fileSizeAtPath(path: (path as NSString).appendingPathComponent(files[i]) as String)
            }
        } catch {
            print("error reading directory, NSFileManager extension folderSizeAtPath")
        }
        return size
    }
    
    func format(size: Int64) -> String {
        let folderSizeStr = ByteCountFormatter.string(fromByteCount: size, countStyle: ByteCountFormatter.CountStyle.file)
        return folderSizeStr
    }
    
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem as Any, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}

