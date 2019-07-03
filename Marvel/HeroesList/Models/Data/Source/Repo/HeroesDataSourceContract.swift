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
    
    associatedtype T:Mappable
    
    func callApi(url:String ,params : Parameters?,headers:HTTPHeaders?) -> Observable<T>?
    
}


protocol HeroesDataLocalSource {
    
    associatedtype U:Object
    
    func fetch()->U?
    
    func fetch(withOffset:Int)->U?
    
    func fetchArray()->[U]?
    
    func insert(heroesResponseModel : U)
    
    func delete()
    
    func searchBy(name:String)->[HeroModel]?
}
