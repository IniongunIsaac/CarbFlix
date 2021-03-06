//
//  Rx+Extensions.swift
//  Food GIG
//
//  Created by Isaac Iniongun on 15/11/2020.
//  Copyright © 2020 Isaac Iniongun. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

extension Realm {
    
    func insertItems<T: Object>(items: [T]) -> Observable<Void> {
        return Observable<Void>.create { observer in
            
            do {
                
                try self.write {
                    self.add(items, update: .modified)
                }
                
                observer.onNext(())
                
            } catch {
                observer.onError(error)
                
            }
            
            return Disposables.create()
        }
    }
    
    func updateItems<T: Object>(items: [T]) -> Observable<Void> {
        return Observable<Void>.create { observer in
            
            do {
                
                try self.write {
                    self.add(items, update: .modified)
                }
                
                observer.onNext(())
                
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func deleteItems<T: Object>(items: [T]) -> Observable<Void> {
        
        return Observable<Void>.create { observer in
            
            do {
                
                try self.write {
                    self.delete(items)
                }
                
                observer.onNext(())
                
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func deleteAllItems<T: Object>(items: Results<T>) -> Observable<Void> {
        
        return Observable<Void>.create { observer in
            
            do {
                
                try self.write {
                    self.delete(items)
                }
                
                observer.onNext(())
                
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func deleteAllItems<T: Object>(for type: T.Type) -> Observable<Void> {
        
        return Observable<Void>.create { observer in
            
            do {
                
                try self.write {
                    self.delete(self.objects(type))
                }
                
                observer.onNext(())
                
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func getSingleElement<T: Object>(primaryKeyValue: String) -> Observable<T?> {
        
        return Observable<T?>.create { observer in
            
            observer.onNext(self.object(ofType: T.self, forPrimaryKey: primaryKeyValue))
            
            return Disposables.create()
        }
    }
    
}
