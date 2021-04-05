//
//  MovieSearch.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 03/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import Foundation

struct MovieSearch: Codable, Scopable {
    let title, year, imdbID: String
    let type: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
