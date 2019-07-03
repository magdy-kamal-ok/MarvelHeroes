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

protocol HeroesViewControllerDelegate: NSObjectProtocol {
    
    func showLoader(flag:Bool)
    func refreshHeroesFinished()
    func loadingMoreHeroesFinished()
    func reloadHeroesData()
    func showAlert(alert:UIAlertController)
}

class HeroesListViewModel: NSObject {
    private var repo = HeroesRepository()
    
    private var disposeBag = DisposeBag()
    public private(set) var resultMessagesObjs = PublishSubject<[HeroModel]>()
    

    var searchString = ""
    var isSearch:Bool = false
    public private(set) var heroesList = [HeroModel]()
    public private(set) var currentOffset: Int = 0
    public private(set) var listTotalCount: Int = 0
    public private(set) var isLoadingMore: Bool = false
    public private(set) var isSwipeAndRefresh : Bool = false
    weak var heroesViewControllerDelegate:HeroesViewControllerDelegate?
    
    private func initializeSubscribers()
    {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        repo.objObservableRemote.asObservable().subscribe(onNext: { (heroesListResponseModel) in
            self.currentOffset =  (heroesListResponseModel.data?.offset)!
            self.listTotalCount = (heroesListResponseModel.data?.total)!
            
            if self.isSwipeAndRefresh
            {
                self.heroesList.removeAll()
            }
           
            if self.isSearch
            {
                heroesListResponseModel.data?.isSearch = 1
                
            }
            self.repo.insert(heroesResponseModel: heroesListResponseModel.data!)
            self.heroesList.append(contentsOf: (heroesListResponseModel.data?.heroesList.toArray())!)

            self.setViewsStates()
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            //
            print("completed")
        }).disposed(by: disposeBag)
        
        repo.objObservableDao.asObservable().subscribe(onNext: { (heroesList) in
            
            if !self.isNetworkConnected()
            {
                self.currentOffset = heroesList.offset
                self.listTotalCount = heroesList.total
                self.heroesList.append(contentsOf: heroesList.heroesList.toArray())
                self.setViewsStates()
            }
            
                
            
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
    
    convenience init(delegate:HeroesViewControllerDelegate) {
        self.init()
        self.heroesViewControllerDelegate = delegate
    }
    
    func removeAllDataSource()
    {
        self.heroesList.removeAll()
        heroesViewControllerDelegate?.reloadHeroesData()

    }
    func getHeroesData()
    {
        var parameters = ParameterModel.init(offset: self.currentOffset).dictionary
        parameters.removeValue(forKey: "name")
        repo.offset = self.currentOffset
        repo.getHeroesData(url: Constants.BASE_URL, data: parameters, headers: nil)
        
    }
    func searchByName(name:String)
    {
        if isNetworkConnected()
        {
            self.currentOffset = 0
            repo.getHeroesData(url: Constants.BASE_URL, data: ParameterModel.init(offset: self.currentOffset, name: name).dictionary, headers: nil)
        }
        else
        {
            if let heroes = repo.searchBy(name: name)
            {
                self.heroesList.append(contentsOf: heroes)
                self.heroesViewControllerDelegate?.reloadHeroesData()
            }
            
        }
    }
    public func refreshMoviesList()
    {
        self.isSwipeAndRefresh = true
        self.currentOffset = 0
        self.getHeroesData()
    }
    public func loadMoreMovies()
    {
        self.isLoadingMore = true
        self.currentOffset += 1
        self.getHeroesData()
    
    }
    
    private func setViewsStates()
    {
        if self.isSwipeAndRefresh
        {
            stopRefreshing()
        }
        else if self.isLoadingMore
        {
            stopLoadingMore()
        }
        heroesViewControllerDelegate?.reloadHeroesData()
    }
    private func stopLoadingMore()
    {
        self.isLoadingMore = false
        heroesViewControllerDelegate?.loadingMoreHeroesFinished()
    }
    private func stopRefreshing()
    {
        self.isSwipeAndRefresh = false
        heroesViewControllerDelegate?.refreshHeroesFinished()
    }
    
    private func stopAllLoaders()
    {
        heroesViewControllerDelegate?.showLoader(flag: false)
        self.stopRefreshing()
        self.stopLoadingMore()
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
