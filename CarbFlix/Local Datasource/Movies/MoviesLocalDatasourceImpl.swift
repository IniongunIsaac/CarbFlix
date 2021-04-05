//
//  MoviesLocalDatasourceImpl.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 04/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

struct MoviesLocalDatasourceImpl: IMoviesLocalDatasource {
    
    let realm: Realm
    
    func getAllMovies() -> Observable<[MovieDetail]> {
        Observable.array(from: realm.objects(MovieDetail.self))
    }
    
    func getMovieById(_ id: String) -> Observable<MovieDetail> {
        Observable.from(optional: realm.object(ofType: MovieDetail.self, forPrimaryKey: id))
    }
    
    func getMovieByName(_ name: String) -> Observable<MovieDetail> {
        Observable.from(optional: realm.objects(MovieDetail.self).filter("title LIKE %@", name).first)
    }
    
    func insertMovies(_ movies: [MovieDetail]) -> Observable<Void> {
        realm.insertItems(items: movies)
    }
    
    func deleteMovies(_ movies: [MovieDetail]) -> Observable<Void> {
        realm.deleteItems(items: movies)
    }
    
}
