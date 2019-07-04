//
//  HeroesCollectionListResponseModel.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//


import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class HeroesCollectionListResponseModel: Object,Mappable {
    
    @objc dynamic var code:Int = 0;
    @objc dynamic var status:String = "";
    @objc dynamic var copyright:String = "";
    @objc dynamic var attributionText:String = "";
    @objc dynamic var attributionHTML:String = "";
    @objc dynamic var etag:String = ""
    @objc dynamic var data:HeroesCollectionListModel?
    
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        code                <- map["code"]
        status              <- map["status"]
        copyright           <- map["copyright"]
        attributionText     <- map["attributionText"]
        attributionHTML     <- map["attributionHTML"]
        data                <- map["data"]
        
    }
    
    
    
}
