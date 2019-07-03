//
//  HeroesDataSourceContract.swift
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


typealias HeroesDataSourceContract = HeroesDataRemoteSource & HeroesDataLocalSource


protocol HeroesDataRemoteSource {
    
    
    func callApi(url:String ,params : Parameters?,headers:HTTPHeaders?) -> Observable<HeroesListResponseModel>?
    
}


protocol HeroesDataLocalSource {
    
    
    func fetch()->HeroesListModel?
    
    func fetch(withOffset:Int)->HeroesListModel?
    
    func fetchArray()->[HeroesListModel]?
    
    func insert(heroesResponseModel : HeroesListModel)
    
    func delete()
    
    func searchBy(name:String)->[HeroModel]?
}
