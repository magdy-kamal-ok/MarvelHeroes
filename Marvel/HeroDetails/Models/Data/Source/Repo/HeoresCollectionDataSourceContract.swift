//
//  HeoresCollectionDataSourceContract.swift
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


typealias HeoresCollectionDataSourceContract = HeoresCollectionDataRemoteSource & HeoresCollectionDataLocalSource


protocol HeoresCollectionDataRemoteSource {
    
    
    func callApi(url:String ,params : Parameters?,headers:HTTPHeaders?) -> Observable<HeroesCollectionListResponseModel>?
    
}


protocol HeoresCollectionDataLocalSource {
    
    func insert(heroCollectionModels : [HeroCollectionModel])
    
    func fetch(withId:Int)-> [HeroCollectionModel]?
}
