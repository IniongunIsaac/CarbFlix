//
//  Rating.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 03/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Rating: Object, Codable {
    dynamic var source: String = ""
    dynamic var value: String = ""
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
    
    convenience init(source: String, value: String) {
        self.init()
        self.source = source
        self.value = value
    }
    
    var sourceValue: String { "\(source)(\(value))" }
}
