//
//  HeroCollectionModel.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class HeroCollectionModel: Object,Mappable {
    
    @objc dynamic var id:Int = 0;
    @objc dynamic var title:String = "";

    var images : List<ThumbnailModel> = List<ThumbnailModel>()

    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id              <- map["id"]
        title           <- map["title"]
        images          <- (map["images"], ListTransform<ThumbnailModel>())

        
    }
    override class func primaryKey() -> String? {
        return "id";
    }
}
