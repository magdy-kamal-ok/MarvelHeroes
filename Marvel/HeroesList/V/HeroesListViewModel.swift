//
//  HeroesListViewModel.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import Reachability
import RxSwift
import RxCocoa
import Alamofire
import RealmSwift
class HeroesListViewModel: NSObject {
    private var repo = HeroesRepository<HeroesListResponseModel,HeroesListModel>()
    
    private var disposeBag = DisposeBag()
    public private(set) var resultMessagesObjs = PublishSubject<[HeroModel]>()
    
    var currentOffset: Int = 1
    var listTotalCount: Int = 1
    var isLoadMore:Bool = false
    var searchString = ""
    var isSearch:Bool = false
    var heroesList = [HeroModel]()
    
    private func initializeSubscribers()
    {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        repo.objObservableRemote.asObservable().subscribe(onNext: { (heroesListResponseModel) in
            self.currentOffset =  (heroesListResponseModel.data?.offset)!
            self.listTotalCount = (heroesListResponseModel.data?.count)!
            
            
           
            if self.isSearch
            {
                heroesListResponseModel.data?.isSearch = 1
                
            }
            self.repo.insert(heroesResponseModel: heroesListResponseModel.data!)
            self.heroesList.append(contentsOf: (heroesListResponseModel.data?.heroesList.toArray())!)

            
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            //
            print("completed")
        }).disposed(by: disposeBag)
        
        repo.objObservableDao.asObservable().subscribe(onNext: { (heroesList) in

                self.currentOffset = heroesList.offset
                self.listTotalCount = heroesList.count
                self.heroesList.append(contentsOf: heroesList.heroesList.toArray())
            
            
                
            
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
    
    
    
    func getHeroesData()
    {
        
        repo.getHeroesData(url: Constants.BASE_URL, data: ParameterModel.init().dictionary, headers: nil)
        
    }
    
    

    fileprivate func isNetworkConnected() -> Bool{
        let reachability = Reachability()!
        return reachability.isReachable
    }
    
    
    func searchLocalDataWith(searchText:String)
    {
//        var filteredItems:[ConversationDataModel] = [ConversationDataModel]()
//        if searchText.isEmpty {
//            self.resultMessagesObjs.onNext(Array(self.resultMessages))
//            return
//        }
//        for msg in self.resultMessages {
//
//            if(msg.users_filter.toArray().first?.translated_name.has(searchText, caseSensitive: false))!
//            {
//                filteredItems.append(msg)
//            }
//        }
//        self.resultMessagesObjs.onNext(filteredItems)
        
    }
    
    
}
