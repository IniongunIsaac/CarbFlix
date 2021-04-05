//
//  Code+Extensions.swift
//  Spottr
//
//  Created by Isaac Iniongun on 16/09/2020.
//  Copyright © 2020 Isaac Iniongun. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

typealias NoParamVoidHandler = () -> Void

let deviceUUID = UIDevice.current.identifierForVendor!.uuidString

func runAfter(_ delay: Double = 2.0, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
        action()
    }
}

func runOnMainThread(action: @escaping () -> Void) {
    DispatchQueue.main.async {
        action()
    }
}

func runEvery(seconds: TimeInterval = 5, block: @escaping () -> Void) -> Timer {
    Timer.scheduledTimer(withTimeInterval: seconds, repeats: true) { _ in block() }
}

func showOrHideErrorMesssage(for view: UIView?, usingLabel errorLabel: UILabel?, shouldShow: Bool, errorMessage: String) {
    if shouldShow {
        animateView { view?.addBorder(toSide: .bottom, withColor: .aSecondaryLabel, andThickness: 1.0) }
        animateView { view?.borderColor = .aSecondaryLabel }
        errorLabel?.text = ""
        errorLabel?.fadeOut()
    } else {
        animateView { view?.borderColor = .primaryColor }
        errorLabel?.text = errorMessage
        errorLabel?.fadeIn()
    }
}

func showOrHideErrorMesssageWithBorderBottom(for view: UIView?, usingLabel errorLabel: UILabel?, shouldShow: Bool, errorMessage: String) {
    if shouldShow {
        errorLabel?.text = "Enter phone number without adding your country code e.g +234"
        errorLabel?.textColor = .darkGray
    } else {
        errorLabel?.text = errorMessage
        errorLabel?.textColor = .appRed
    }
}

func animateView(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }, codeToAnimate: @escaping () -> Void) {
    UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
        codeToAnimate()
    }, completion: completion)
}

func randomString(length: Int = 11) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

extension Set {
    var toArray: [Element] {
        return Array(self)
    }
}

extension Collection {
    func chunk(n: Int) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}

extension String {
    func chunkFormatted(withChunkSize chunkSize: Int = 4, withSeparator separator: Character = " ") -> String {
        return self.filter { $0 != separator }.chunk(n: chunkSize).map{ String($0) }.joined(separator: String(separator))
    }
    
    func formatWith234() -> String {
        var value = self
        value.replaceSubrange(value.startIndex...value.startIndex, with: "+234")
        return value
    }
    
    var remove234: String {
        return self.replacingOccurrences(of: "+234", with: "0")
    }
    
    var orDash: String {
        return self.isEmpty ? "-" : self
    }
    
    var orEmpty: String {
        return self.isEmpty ? "" : self
    }
    
    var numbers: String {
        return filter { "0"..."9" ~= $0 }
    }
    
    var double: Double? {
        Double(self)
    }
    
    var float: Float? {
        Float(self)
    }
    
    var int: Int? {
        Int(self)
    }
    
    func insensitiveEquals(_ value: String) -> Bool {
        localizedCaseInsensitiveCompare(value) == .orderedSame
    }
    
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self?.isEmpty ?? true ? "" : self!
    }
    
    var orNA: String {
        return self?.isEmpty ?? true ? "N/A" : self!
    }
}

func restrictTextfieldToDigitsWithMaximumLength(textField: UITextField, range: NSRange, string: String, maxLength: Int) -> Bool {
    // get the current text, or use an empty string if the failed
    let currentText = textField.text ?? ""

    // attempt to read the range they are trying to change, or exit if we can't
    guard let stringRange = Range(range, in: currentText) else { return false }

    // add their new text to the existing text
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    
    //  make sure the result is under `maxLength` characters and remove non-numerics and compare with original string
    return string == string.filter("0123456789".contains) && updatedText.count <= maxLength
    
}

//MARK: - Substrings
extension String {
    
    subscript (start: Int, end: Int) -> Substring {
        let startPos = index(startIndex, offsetBy: start)
        let endPos: String.Index
        if end > 0 {
            endPos = index(startIndex, offsetBy: end)
        } else {
            endPos = index(endIndex, offsetBy: end)
        }
        return self[startPos...endPos]
    }
    
    subscript (pos: Int) -> Character {
        if pos > 0 {
            return self[index(startIndex, offsetBy: pos)]
            
        }
        return self[index(endIndex, offsetBy: pos)]
    }
    
}

//MARK: - Current Date Year and Month

func currentYear() -> String {
    let date = Date()
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: date) // gets current year (i.e. 2017)
    
    return "\(currentYear)"
}

func currentMonth() -> String {
    let date = Date()
    let calendar = Calendar.current
    let currentMonth = calendar.component(.month, from: date) // gets current month (i.e. 10)
    
    return "\(currentMonth)"
}

func currentYearFirstTwoDigits() -> Int {
    return Int(currentYear()[0,1])!
}

func currentYearLastTwoDigits() -> Int {
    return Int(currentYear()[2,3])!
}

extension Collection where Iterator.Element == Int {
    var seatsString: String {
        return String(describing: self.compactMap { $0 }).replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
    }
}

extension Data {
    var mbSize: Float {
        return Float(Float(self.count) / 1048576.0)
    }
}

extension UIApplication {

  func setRootViewController(_ vc : UIViewController) {
      self.windows.first?.rootViewController = vc
      self.windows.first?.makeKeyAndVisible()
    }
}

func openInBrowser(url: String) {
    if let url = URL(string: url) {
        UIApplication.shared.open(url)
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
    
    func toSet() -> Set<Self> {
        Set(arrayLiteral: self)
    }
}

extension Array where Element: Equatable {
    func subtracting(_ array: Array<Element>) -> Array<Element> {
        self.filter { !array.contains($0) }
    }
}

extension Collection {
    func isNotEmpty() -> Bool {
        !self.isEmpty
    }
}

extension Int {
    var currencyFormatted: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.groupingSeparator = ","
        currencyFormatter.groupingSize = 3
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .none
        
        return "₦\(currencyFormatter.string(from: NSNumber(value: self))!)"
    }
 
    var double: Double {
        Double(self)
    }
    
    var float: Float {
        Float(self)
    }
}

extension Float {
    
    var currencyFormatted: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.groupingSeparator = ","
        currencyFormatter.groupingSize = 3
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .none
        
        return "₦\(currencyFormatter.string(from: NSNumber(value: self))!)"
    }
    
    var int: Int {
        Int(self)
    }
}

extension Double {
    var int: Int {
        Int(self)
    }
}

extension Numeric {
    
    var double: Double {
        Double(truncating: self as! NSNumber)
    }
    
    var float: Float {
        Float(truncating: self as! NSNumber)
    }
    
    var int: Int {
        Int(truncating: self as! NSNumber)
    }
    
}

extension RangeReplaceableCollection where Element: Equatable {
    @discardableResult
    mutating func appendIfNotExists(_ element: Element) -> (appended: Bool, memberAfterAppend: Element) {
        if let index = firstIndex(of: element) {
            return (false, self[index])
        } else {
            append(element)
            return (true, element)
        }
    }
}

extension Array where Element == String {
    func caseInsensitiveContains(_ element: Element) -> Bool {
        contains { $0.caseInsensitiveCompare(element) == .orderedSame }
    }
}

func getInfoPlistData() -> [String: Any]? {
    if  let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let xml = FileManager.default.contents(atPath: path) {
        return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [String: Any]
    }
    return nil
}

extension Encodable {
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    
    var prettyPrinted: String {
        let responseData = try! JSONSerialization.data(withJSONObject: self.dictionary, options: .prettyPrinted)
        return String(data: responseData, encoding: .utf8)!
    }
}

extension Dictionary {
    var prettyPrinted: String {
        let responseData = try! JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        return String(data: responseData, encoding: .utf8)!
    }
}

func printIfDebugOrStagingScheme(_ message: Any, _ messageType: AlertType = .error, isJsonResponse: Bool = false) {
    #if DEBUG || STAGING
    switch messageType {
    case .error:
        print("🔴🔴🔴 " + String(describing: message))
    case .success:
        if isJsonResponse {
            print("Request Response: 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢")
            print(message)
        } else {
            print("🟢🟢🟢 " + String(describing: message))
        }
    case .info:
        print("🟡🟡🟡 " + String(describing: message))
    }
    #endif
}

func isLiveEnvironment() -> Bool {
    #if DEBUG || STAGING
        return false
    #else
        return true
    #endif
    
}

extension Optional {
    var isNil : Bool {
        self == nil
    }
    
    var isNotNil : Bool {
        self != nil
    }
}

func resizedImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
    UIGraphicsBeginImageContext(newSize)
    image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!.withRenderingMode(.alwaysOriginal)
}
