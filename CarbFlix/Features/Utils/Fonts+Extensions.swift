//
//  Fonts+Extensions.swift
//  Spottr
//
//  Created by Isaac Iniongun on 16/09/2020.
//  Copyright © 2020 Isaac Iniongun. All rights reserved.
//

import Foundation
import UIKit

func printAvailableFonts() {
    UIFont.familyNames.forEach({ familyName in
        let fontNames = UIFont.fontNames(forFamilyName: familyName)
        print(familyName, fontNames)
    })
}

extension UIFont {
    
    class func sfProDisplayBlack(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayBlack(size: size)! }
    
    class func sfProDisplayRegular(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayRegular(size: size)! }
    
    class func sfProDisplayBoldItalic(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayBoldItalic(size: size)! }
    
    class func sfProDisplayBold(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayBold(size: size)! }
    
    class func sfProDisplayThinItalic(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayThinItalic(size: size)! }
    
    class func sfProDisplayThin(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayThin(size: size)! }
    
    class func sfProDisplayLight(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayRegular(size: size)! }
    
    class func sfProDisplayLightItalic(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayLightItalic(size: size)! }
    
    class func sfProDisplaySemiBold(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayBold(size: size)! }
    
    class func sfProDisplaySemiBoldItalic(size: CGFloat = 16) -> UIFont { R.font.sfProDisplaySemiboldItalic(size: size)! }
    
    class func sfProDisplayUltraLight(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayUltralight(size: size)! }
    
    class func sfProDisplayUltraLightItalic(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayUltralightItalic(size: size)! }
    
    class func sfProDisplayBlackItalic(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayBlackItalic(size: size)! }
    
    class func sfProDisplayItalic(size: CGFloat = 16) -> UIFont { R.font.sfProDisplayItalic(size: size)! }
}
