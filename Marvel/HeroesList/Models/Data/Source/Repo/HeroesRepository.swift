//
//  HeroesRepository.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//


import Foundation
import RxSwift
import ObjectMapper
import RealmSwift
import Alamofire


class HeroesRepository<REMOTE:Mappable,LOCAL:Object>:
HeroesDataSourceContract {
    
    typealias T = REMOTE
    
    private let objMessagesRequestClass:HeroesRequestClass = HeroesRequestClass<REMOTE>()
    private let objMessageDao:HeoresDao = HeoresDao<LOCAL>()
    
    public private(set) var objObservableDao = PublishSubject<LOCAL>()
    public private(set) var objObservableRemote = PublishSubject<REMOTE>()
    
    public var errorModel = PublishSubject<ErrorModel>()
    public var offset = 0
    
    private var bag = DisposeBag()
    
    
    func getHeroesData(url:String, data:Parameters?, headers:HTTPHeaders?, bool:Bool = true)
    {
        if bool{
            if let cashedData = self.fetch(withOffset: offset)
            {
                objObservableDao.onNext(cashedData)
                
                self.callBackEndApi(url: url, params: data, headers: headers)
            }
            else{
                self.callBackEndApi(url: url, params: data, headers: headers)
            }
            
        }
        else
        {
            self.callBackEndApi(url: url, params: data, headers: headers)
        }
    }
    func callBackEndApi(url: String, params: Parameters?, headers: HTTPHeaders?)
    {
        self.callApi(url: url, params: params, headers: headers)?.subscribe({ (subObj) in
            
            switch subObj
            {
            case .next(let responseObj):
                self.objObservableRemote.onNext(responseObj)
            case .error(_):
                if let resultData = self.fetch(withOffset: self.offset)
                {
                    //  _ =  self.repo1.fetch()
                    
                    self.objObservableDao.onNext(resultData)
                }
                else{
                    
                    self.errorModel.onNext(ErrorModel(desc: "network first time fail", code: 404))
                }
            case .completed:
                print("Completed")
            }
            
        }).disposed(by: bag)

    }
    
    func callApi(url: String, params: Parameters?, headers: HTTPHeaders?) -> Observable<REMOTE>? {
        if let objObserve = objMessagesRequestClass.callApi(url: url,   params: params, headers: headers)
        {
            return objObserve
        }
        return Observable.empty()
    }
}
extension HeroesRepository{
    typealias U = LOCAL
    
    func fetch() -> LOCAL? {
        return objMessageDao.fetch()
    }
    
    func fetch(withOffset: Int) -> LOCAL? {
        return objMessageDao.fetch(withOffset: withOffset)
    }
    
    func fetchArray() -> [LOCAL]? {
        return objMessageDao.fetchArray()
    }
    
    func insert(heroesResponseModel: LOCAL) {
        objMessageDao.insert(heroesResponseModel: heroesResponseModel)
    }
    
    
    func delete() {
        objMessageDao.delete()
    }
    
}
