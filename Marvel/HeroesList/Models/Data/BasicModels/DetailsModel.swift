//
//  ComicsModel.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class DetailsModel: Object,Mappable {
    
    
    @objc dynamic var available:Int = 0;
    @objc dynamic var returned:Int = 0;
    @objc dynamic var collectionURI:String = "";
    var items : List<DetailsItemModel> = List<DetailsItemModel>()
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        available          <- map["available"]
        returned           <- map["returned"]
        collectionURI      <- map["collectionURI"]
        items         <- (map["items"], ListTransform<DetailsItemModel>())
        
    }

    
}
