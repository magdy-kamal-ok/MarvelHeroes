//
//  UrlModel.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class UrlModel: Object,Mappable {
    
    @objc dynamic var type:String = "";
    @objc dynamic var url:String = "";
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        type           <- map["type"]
        url            <- map["url"]
    }
    
}
