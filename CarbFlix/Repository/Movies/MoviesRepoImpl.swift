//
//  MoviesRepoImpl.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 04/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import Foundation
import RxSwift

struct MoviesRepoImpl: IMoviesRepo {
    
    let remote: IMoviesRemoteDatasource
    let local: IMoviesLocalDatasource
    
    func search(params: BodyParam) -> Observable<MovieSearchRes> {
        remote.search(params: params)
    }
    
    func getMovieDetails(params: BodyParam) -> Observable<MovieDetail> {
        remote.getMovieDetails(params: params)
    }
    
    func getAllMovies() -> Observable<[MovieDetail]> {
        local.getAllMovies()
    }
    
    func getMovieById(_ id: String) -> Observable<MovieDetail> {
        local.getMovieById(id)
    }
    
    func getMovieByName(_ name: String) -> Observable<MovieDetail> {
        local.getMovieByName(name)
    }
    
    func insertMovies(_ movies: [MovieDetail]) -> Observable<Void> {
        local.insertMovies(movies)
    }
    
    func deleteMovies(_ movies: [MovieDetail]) -> Observable<Void> {
        local.deleteMovies(movies)
    }
    
}
