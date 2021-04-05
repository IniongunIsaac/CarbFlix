//
//  MovieSearchRes.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 03/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import Foundation

struct MovieSearchRes: Codable {
    let results: [MovieSearch]
    let totalResults, response: String
    
    enum CodingKeys: String, CodingKey {
        case results = "Search"
        case totalResults
        case response = "Response"
    }
}
