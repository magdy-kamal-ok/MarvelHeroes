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


class HeroesRepository:HeroesDataSourceContract {
  
    
    
    private let objMessagesRequestClass:HeroesRequestClass = HeroesRequestClass()
    private let objMessageDao:HeoresDao = HeoresDao()
    
    public private(set) var objObservableDao = PublishSubject<HeroesListModel>()
    public private(set) var objObservableRemote = PublishSubject<HeroesListResponseModel>()
    
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
                
                self.errorModel.onNext(ErrorModel(desc: "network first time fail", code: 600))
                
            case .completed:
                print("Completed")
            }
            
        }).disposed(by: bag)

    }
    
    func callApi(url: String, params: Parameters?, headers: HTTPHeaders?) -> Observable<HeroesListResponseModel>? {
        if let objObserve = objMessagesRequestClass.callApi(url: url,   params: params, headers: headers)
        {
            return objObserve
        }
        return Observable.empty()
    }
}
extension HeroesRepository{
    
    func fetch() -> HeroesListModel? {
        return objMessageDao.fetch()
    }
    
    func fetch(withOffset: Int) -> HeroesListModel? {
        return objMessageDao.fetch(withOffset: withOffset)
    }
    
    func fetchArray() -> [HeroesListModel]? {
        return objMessageDao.fetchArray()
    }
    
    func insert(heroesResponseModel: HeroesListModel) {
        objMessageDao.insert(heroesResponseModel: heroesResponseModel)
    }
    
    
    func delete() {
        objMessageDao.delete()
    }
    func searchBy(name: String) -> [HeroModel]? {
        return objMessageDao.searchBy(name: name)
    }
}

