//
//  HeroesCollectionListModel.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class HeroesCollectionListModel: Object,Mappable {
    

    @objc dynamic var offset:Int = 0
    @objc dynamic var limit:Int = 0;
    @objc dynamic var total:Int = 0;
    @objc dynamic var count:Int = 0;
    @objc dynamic var isSearch:Int = 0 
    
    var heroesCollectionList : List<HeroCollectionModel> = List<HeroCollectionModel>()
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        offset          <- map["offset"]
        limit           <- map["limit"]
        total           <- map["total"]
        count           <- map["count"]
        heroesCollectionList      <- (map["results"], ListTransform<HeroCollectionModel>())
    
        
    }
    
    
}
