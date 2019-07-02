//
//  HeroesRequestClass.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Alamofire

class HeroesRequestClass<U:Mappable>: HeroesDataRemoteSource {
    
    typealias T = U
    
    func callApi(url:String ,params : Parameters?, headers:HTTPHeaders?)->Observable<U>? {
        return  Observable.create{
            observer in
            Alamofire.request(url,
                              method: .get,
                              parameters: params, encoding: URLEncoding(destination: .queryString),headers:headers
                )
                .responseJSON { response in
                    switch response.result {
                    case .success(let json):
                        guard let value = json as? [String: Any]
                            else {
                                return
                        }
                        let responseObj = U(JSON: value)
                        observer.onNext(responseObj!)
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create {
                
            }
        }
    }
}
