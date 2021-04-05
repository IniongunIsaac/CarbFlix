//
//  BaseViewModel.swift
//  Spottr
//
//  Created by Isaac Iniongun on 16/09/2020.
//  Copyright © 2020 Isaac Iniongun. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    let isLoading: PublishSubject<Bool> = PublishSubject()
    
    let alertMessage: PublishSubject<AlertMessage> = PublishSubject()
    
    let error: PublishSubject<Error> = PublishSubject()
    
    func viewDidLoad() { }
    
    func viewWillAppear() { }
    
    func viewDidAppear() { }
    
    func viewWillDisappear() { }
    
    func viewDidDisappear() { }
    
    func emitFalseLoadingAndErrorValues(error: Error) {
        isLoading.onNext(false)
        self.error.onNext(error)
    }
    
    func showLoading(_ shouldShow: Bool = true) {
        isLoading.onNext(shouldShow)
    }
    
    func showMessage(_ message: String, type: AlertType = .success) {
        alertMessage.onNext(AlertMessage(message: message, type: type))
    }
    
    func subscribe<T>(_ observable: Observable<T>, showLoadingAnimation: Bool = true, showMessageAlerts: Bool = true, errorMessage: String? = nil, success: ((T) -> Void)? = nil, error: ((Error) -> Void)? = nil) {
        showLoading(showLoadingAnimation)
        observable.subscribe(onNext: { [weak self] value in
            self?.showLoading(false)
            success?(value)
        }, onError: { [weak self] err in
            self?.showLoading(false)
            
            if showMessageAlerts {
                if let errorMessage = errorMessage {
                    self?.showMessage(errorMessage, type: .error)
                }
                if let error = error {
                    error(err)
                } else {
                    self?.emitFalseLoadingAndErrorValues(error: err)
                }
            }
            
        }).disposed(by: disposeBag)
    }
    
}
