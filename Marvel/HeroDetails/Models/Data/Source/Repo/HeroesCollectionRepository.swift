//
//  HeroesCollectionRepository.swift
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


class HeroesCollectionRepository:HeoresCollectionDataSourceContract {
  
    
    
    private let objDetailedHeroRequestClass:HeroesCollectionRequestClass = HeroesCollectionRequestClass()
    private let objDetailedHeroDao:HeoresCollectionDao = HeoresCollectionDao()
    
    public private(set) var objObservableDao = PublishSubject<[HeroCollectionModel]>()
    public private(set) var objObservableRemote = PublishSubject<HeroesCollectionListResponseModel>()
    
    public var errorModel = PublishSubject<ErrorModel>()
    
    private var bag = DisposeBag()
    
    var id = 0
    
    func getHeroesCollectionData(url:String, data:Parameters?, headers:HTTPHeaders?, bool:Bool = true)
    {
        if bool{
            if let cashedData = self.fetch(withId:self.id)
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
    
    func callApi(url: String, params: Parameters?, headers: HTTPHeaders?) -> Observable<HeroesCollectionListResponseModel>? {
        if let objObserve = objDetailedHeroRequestClass.callApi(url: url,   params: params, headers: headers)
        {
            return objObserve
        }
        return Observable.empty()
    }
}
extension HeroesCollectionRepository{

    func insert(heroCollectionModels : [HeroCollectionModel])
    {
        objDetailedHeroDao.insert(heroCollectionModels: heroCollectionModels)
    }
    
    func fetch(withId:Int)-> [HeroCollectionModel]?
    {
        return objDetailedHeroDao.fetch(withId: withId)
    }


    
}

