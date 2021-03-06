//
//  Numbers+Extensions.swift
//  Food GIG
//
//  Created by Isaac Iniongun on 12/11/2020.
//  Copyright © 2020 Isaac Iniongun. All rights reserved.
//

import Foundation

protocol FormattableNumeric {}

extension FormattableNumeric {
    
    var localized: String {
        guard let number = self as? NSNumber else { return "NaN" }
        return number.description(withLocale: Locale.current)
    }
    
    func decimalPlaces(_ places: Int = 2) -> String {
        String(format: "%.\(places)f", self as! NSNumber)
    }
    
    var currencyFormatted: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.groupingSeparator = ","
        currencyFormatter.groupingSize = 3
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .none
        
        return "₦\(currencyFormatter.string(from: self as! NSNumber)!)"
    }
    
    var string: String { "\(self as! NSNumber)" }
}
extension Int: FormattableNumeric {}
extension Float: FormattableNumeric {}
extension Double: FormattableNumeric {}
