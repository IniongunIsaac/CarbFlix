//
//  IMoviesRemoteDatasource.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 03/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import Foundation
import RxSwift

protocol IMoviesRemoteDatasource {
    
    func search(params: BodyParam) -> Observable<MovieSearchRes>
    
    func getMovieDetails(params: BodyParam) -> Observable<MovieDetail>
    
}
