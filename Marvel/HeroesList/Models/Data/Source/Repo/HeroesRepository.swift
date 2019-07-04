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
  
    
    
    private let objHeroessRequestClass:HeroesRequestClass = HeroesRequestClass()
    private let objHeroesDao:HeoresDao = HeoresDao()
    
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
        if let objObserve = objHeroessRequestClass.callApi(url: url,   params: params, headers: headers)
        {
            return objObserve
        }
        return Observable.empty()
    }
}
extension HeroesRepository{
    
    func fetch() -> HeroesListModel? {
        return objHeroesDao.fetch()
    }
    
    func fetch(withOffset: Int) -> HeroesListModel? {
        return objHeroesDao.fetch(withOffset: withOffset)
    }
    
    func fetchArray() -> [HeroesListModel]? {
        return objHeroesDao.fetchArray()
    }
    
    func insert(heroesResponseModel: HeroesListModel) {
        objHeroesDao.insert(heroesResponseModel: heroesResponseModel)
    }
    
    
    func delete() {
        objHeroesDao.delete()
    }
    func searchBy(name: String) -> [HeroModel]? {
        return objHeroesDao.searchBy(name: name)
    }
}

