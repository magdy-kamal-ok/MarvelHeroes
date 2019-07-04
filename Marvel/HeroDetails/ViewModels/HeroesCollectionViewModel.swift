//
//  HeroesCollectionViewModel.swift
//  Marvel
//
//  Created by mac on 7/4/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import Reachability
import RxSwift
import RxCocoa
import Alamofire
import RealmSwift

class HeroesCollectionViewModel: NSObject {
    
    private var repo = HeroesCollectionRepository()
    private var disposeBag = DisposeBag()
    private var url:String = ""
    public private(set) var objObservableResult = PublishSubject<[HeroCollectionModel]>()

    private func initializeSubscribers()
    {
        repo.objObservableRemote.asObservable().subscribe(onNext: { (herosCollectionModel) in
            
            let responseResult = herosCollectionModel.data?.heroesCollectionList.toArray()
            self.repo.insert(heroCollectionModels: responseResult ?? [])
            self.objObservableResult.onNext(responseResult ?? [])
            
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            //
            print("completed")
        }).disposed(by: disposeBag)
        
        repo.objObservableDao.asObservable().subscribe(onNext: { (herosCollectionModel) in
            
            if !self.isNetworkConnected()
            {
                self.objObservableResult.onNext(herosCollectionModel)
            }
            
            
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            //
        }).disposed(by: disposeBag)
        
        repo.errorModel.asObservable().subscribe(onNext: { (error) in
            
            self.getHeroesCollectionData(url: self.url)
            
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            //
        }).disposed(by: disposeBag)
    }
    
    override init() {
        super.init()
        initializeSubscribers()
    }
    
    

    func getHeroesCollectionData(url:String)
    {
        self.url = url
        var parameters = ParameterModel.init().dictionary
        parameters.removeValue(forKey: "name")
        parameters.removeValue(forKey: "offset")
        let subArray =  url.components(separatedBy: "/")
        repo.id = Int(subArray.last!)!
        repo.getHeroesCollectionData(url: url, data: parameters, headers: nil)
        
    }
    
    fileprivate func isNetworkConnected() -> Bool{
        let reachability = Reachability()!
        return reachability.isReachable
    }
    
    
    
    
    
}
