//
//  BaseRemoteDataSourceImpl.swift
//  Spottr
//
//  Created by Isaac Iniongun on 05/09/2020.
//  Copyright © 2020 Isaac Iniongun. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

class BaseRemoteDataSourceImpl: IBaseRemoteDataSource {
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let manager = Session.default
    
    func makeAPIRequest<T>(responseType: T.Type, url: String = AppConstants.Keys.BASE_URL, method: HTTPMethod = .get, params: [String : Any]? = nil, encoding: ParameterEncoding = URLEncoding.default) -> Observable<T> where T : Decodable, T : Encodable {
        
        printIfDebugOrStagingScheme("Request URL: \(url)", .info)
        printIfDebugOrStagingScheme("Request Parameters:\n \(String(describing: params))", .info)
        
        return manager.rx.request(method, url, parameters: params, encoding: encoding)
            .validate(statusCode: 200 ..< 499)
            .debug()
            .responseString()
            .flatMap { (_, responseString) -> Observable<T> in
                do {
                    printIfDebugOrStagingScheme(responseString, .info)
                    
                    //map the result of `responseString` above to the `responseType`
                    let requestResponse = try responseType.mapTo(jsonString: responseString)!
                    printIfDebugOrStagingScheme(requestResponse.prettyPrinted, .success, isJsonResponse: true)
                    //return result in `requestResponse` above in the `successHandler`
                    return Observable.just(requestResponse)
                    
                } catch let error {
                    printIfDebugOrStagingScheme(error)
                    throw error
                }
        }
        .observeOn(MainScheduler.instance)
        
    }
    
}
