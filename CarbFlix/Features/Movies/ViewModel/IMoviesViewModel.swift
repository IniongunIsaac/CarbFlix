//
//  IMoviesViewModel.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 04/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import Foundation
import RxSwift

protocol IMoviesViewModel: Scopable {
    
    var movies: PublishSubject<[MovieSearch]> { get }
    
    var movie: PublishSubject<MovieDetail> { get }
    
    var favoriteMovies: PublishSubject<[MovieDetail]> { get }
    
    func emitEmptyMovies()
    
    func getMovies()
    
    func getMovieDetails(_ id: String)
    
    func addMovieToFavorites(_ movie: MovieDetail)
    
    func getFavoriteMovies()
    
    func emitEmptyFavoriteMovies()
    
    func searchMovies(using searchText: String)
    
}
