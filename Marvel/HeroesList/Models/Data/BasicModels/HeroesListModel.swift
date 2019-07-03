//
//  HeroesListModel.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class HeroesListModel: Object,Mappable {
    

    @objc dynamic var offset:Int = 0{
        didSet {
            compoundKey = compoundKeyValue()
        }
    }
    @objc dynamic var limit:Int = 0;
    @objc dynamic var total:Int = 0;
    @objc dynamic var count:Int = 0;
    @objc dynamic var isSearch:Int = 0 {
        didSet {
            compoundKey = compoundKeyValue()
        }
    }
    @objc dynamic var compoundKey: String = ""
    
    var heroesList : List<HeroModel> = List<HeroModel>()
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        offset          <- map["offset"]
        limit           <- map["limit"]
        total           <- map["total"]
        count           <- map["count"]
        heroesList      <- (map["results"], ListTransform<HeroModel>())
    
        
    }
    
    
    override class func primaryKey() -> String? {
        return "compoundKey";
    }
    
    private func compoundKeyValue() -> String {
        return "\(isSearch)-\(offset)"
    }
    
}
