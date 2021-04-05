//
//  AppDependencyGraph.swift
//  Spottr
//
//  Created by Isaac Iniongun on 16/09/2020.
//  Copyright © 2020 Isaac Iniongun. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import RealmSwift

extension SwinjectStoryboard {
    
    public static func setup() {
        
        runRealmMigrations()
        
        defaultContainer.register(Realm.self) { _ in try! Realm() }
        
        defaultContainer.register(IMoviesLocalDatasource.self) { MoviesLocalDatasourceImpl(realm: $0.resolve(Realm.self)!) }
        
        defaultContainer.register(IMoviesRemoteDatasource.self) { _ in MoviesRemoteDatasourceImpl() }
        
        defaultContainer.register(IMoviesRepo.self) { MoviesRepoImpl(remote: $0.resolve(IMoviesRemoteDatasource.self)!, local: $0.resolve(IMoviesLocalDatasource.self)!) }
        
        defaultContainer.register(IMoviesViewModel.self) { MoviesViewModelImpl(moviesRepo: $0.resolve(IMoviesRepo.self)!) }
        
        defaultContainer.storyboardInitCompleted(MoviesViewController.self) { $1.moviesViewModel = $0.resolve(IMoviesViewModel.self)! }
        
        defaultContainer.storyboardInitCompleted(FavoriteMoviesViewController.self) { $1.moviesViewModel = $0.resolve(IMoviesViewModel.self)! }
        
        defaultContainer.storyboardInitCompleted(SearchMoviesViewController.self) { $1.moviesViewModel = $0.resolve(IMoviesViewModel.self)! }
        
        defaultContainer.storyboardInitCompleted(MovieDetailsViewController.self) { $1.moviesViewModel = $0.resolve(IMoviesViewModel.self)! }
        
    }
    
    fileprivate static func runRealmMigrations() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 2,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                
            })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
}
