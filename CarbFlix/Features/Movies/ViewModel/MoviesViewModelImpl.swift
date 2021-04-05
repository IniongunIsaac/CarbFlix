//
//  MoviesViewModelImpl.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 04/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import Foundation
import RxSwift

class MoviesViewModelImpl: BaseViewModel, IMoviesViewModel {
    
    var movies: PublishSubject<[MovieSearch]> = PublishSubject()
    var movie: PublishSubject<MovieDetail> = PublishSubject()
    var favoriteMovies: PublishSubject<[MovieDetail]> = PublishSubject()
    
    let moviesRepo: IMoviesRepo!
    
    init(moviesRepo: IMoviesRepo) {
        self.moviesRepo = moviesRepo
    }
    
    func emitEmptyMovies() {
        movies.onNext([])
    }
    
    func getMovies() {
        subscribe(Observable.zip(moviesRepo.search(params: getSearchParams()), moviesRepo.search(params: getSearchParams(page: 2))), success: { [weak self] movieRes1, movieRes2 in
            self?.movies.onNext(movieRes1.results + movieRes2.results)
        }) { [weak self] _ in
            self?.emitEmptyMovies()
        }
    }
    
    fileprivate func getSearchParams(searchTerm: String = "Batman", page: Int = 1) -> BodyParam {
        [
            "apikey": AppConstants.Keys.OMDB_API_KEY,
            "s": searchTerm,
            "page": page.string
        ]
    }
    
    func getMovieDetails(_ id: String) {
        let params = [
            "apikey": AppConstants.Keys.OMDB_API_KEY,
            "i": id
        ]
        subscribe(moviesRepo.getMovieDetails(params: params), success: { [weak self] movie in
            self?.movie.onNext(movie)
        })
    }
    
    func addMovieToFavorites(_ movie: MovieDetail) {
        subscribe(moviesRepo.insertMovies([movie]), success: { [weak self] in
            self?.showMessage("Movie added to favorites")
        })
    }
    
    func emitEmptyFavoriteMovies() {
        favoriteMovies.onNext([])
    }
    
    func getFavoriteMovies() {
        subscribe(moviesRepo.getAllMovies(), success: { [weak self] movies in
            self?.favoriteMovies.onNext(movies)
        })
    }
    
    func searchMovies(using searchText: String) {
        subscribe(moviesRepo.search(params: getSearchParams(searchTerm: searchText)), showMessageAlerts: false, success: { [weak self] moviesRes in
            self?.movies.onNext(moviesRes.results)
        }) { [weak self] _ in
            self?.emitEmptyMovies()
        }
    }
}
