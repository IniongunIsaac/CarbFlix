//
//  MovieDetail.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 03/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class MovieDetail: Object, Codable {
    dynamic var title: String? = ""
    dynamic var year: String? = ""
    dynamic var rated: String? = ""
    dynamic var released: String? = ""
    dynamic var runtime: String? = ""
    dynamic var genre: String? = ""
    dynamic var director: String? = ""
    dynamic var writer: String? = ""
    dynamic var actors: String? = ""
    dynamic var plot: String? = ""
    dynamic var language: String? = ""
    dynamic var country: String? = ""
    dynamic var awards: String? = ""
    dynamic var poster: String? = ""
    dynamic var metascore: String? = ""
    dynamic var imdbRating: String? = ""
    dynamic var imdbVotes: String? = ""
    dynamic var imdbID: String = ""
    dynamic var type: String? = ""
    dynamic var dvd: String? = ""
    dynamic var boxOffice: String? = ""
    dynamic var production: String? = ""
    dynamic var website: String? = ""
    dynamic var response: String? = ""
    var ratings = List<Rating>()
    
    override class func primaryKey() -> String? { "imdbID" }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
    
    convenience init(title: String?, year: String?, rated: String?, released: String?, runtime: String?, genre: String?, director: String?, writer: String?, actors: String?, plot: String?, language: String?, country: String?, awards: String?, poster: String?, metascore: String?, imdbRating: String?, imdbVotes: String?, imdbID: String, type: String?, dvd: String?, boxOffice: String?, production: String?, website: String?, response: String?, ratings: [Rating]) {
        self.init()
        self.title = title
        self.year = year
        self.rated = rated
        self.released = released
        self.runtime = runtime
        self.genre = genre
        self.director = director
        self.writer =  writer
        self.actors = actors
        self.plot = plot
        self.language = language
        self.country = country
        self.awards = awards
        self.poster = poster
        self.metascore = metascore
        self.imdbRating = imdbRating
        self.imdbVotes = imdbVotes
        self.imdbID = imdbID
        self.type = type
        self.dvd = dvd
        self.boxOffice = boxOffice
        self.production = production
        self.website = website
        self.response = response
        self.ratings.append(objectsIn: ratings)
    }
    
    var ratingsText: String {
        ratings.map { $0.sourceValue }.joined(separator: ", ")
    }
    
    var movie: MovieSearch {
        MovieSearch(title: title.orNA, year: year.orNA, imdbID: imdbID, type: type.orNA, poster: poster.orNA)
    }
}
