//
//  AppConstants.swift
//  Spottr
//
//  Created by Isaac Iniongun on 16/09/2020.
//  Copyright © 2020 Isaac Iniongun. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    static let DATE_FORMAT = "dd MMM yyyy"
    static let CURRENT_YEAR_LAST_TWO_DIGITS = "\(currentYearLastTwoDigits())"
    static let CURRENT_YEAR_LAST_TWO_DIGITS_PLUS_10 = "\(currentYearLastTwoDigits() + 10)"
    static let DATA_NOT_FOUND = "No data available at the moment!"
    static let APP_ERROR_CODE = -9999
    
    struct Keys {
        
        static let OMDB_API_KEY = getInfoPlistData()!["OMDB_API_KEY"] as! String
        
        static let BASE_URL = getInfoPlistData()!["BASE_URL"] as! String
        
    }
    
}
