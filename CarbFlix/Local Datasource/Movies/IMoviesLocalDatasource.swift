//
//  IMoviesLocalDatasource.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 04/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import Foundation
import RxSwift

protocol IMoviesLocalDatasource {
    
    func getAllMovies() -> Observable<[MovieDetail]>
    
    func getMovieById(_ id: String) -> Observable<MovieDetail>
    
    func getMovieByName(_ name: String) -> Observable<MovieDetail>
    
    func insertMovies(_ movies: [MovieDetail]) -> Observable<Void>
    
    func deleteMovies(_ movies: [MovieDetail]) -> Observable<Void>
    
}
