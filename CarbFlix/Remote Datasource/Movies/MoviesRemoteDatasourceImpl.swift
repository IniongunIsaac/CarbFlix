//
//  MoviesRemoteDatasourceImpl.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 04/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import Foundation
import RxSwift

class MoviesRemoteDatasourceImpl: BaseRemoteDataSourceImpl, IMoviesRemoteDatasource {
    
    func search(params: BodyParam) -> Observable<MovieSearchRes> {
        makeAPIRequest(responseType: MovieSearchRes.self, params: params)
    }
    
    func getMovieDetails(params: BodyParam) -> Observable<MovieDetail> {
        makeAPIRequest(responseType: MovieDetail.self, params: params)
    }
    
}
