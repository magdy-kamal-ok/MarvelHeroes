//
//  ComicItemModel.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class DetailsItemModel: Object,Mappable {
    
    @objc dynamic var resourceURI:String = "";
    @objc dynamic var name:String = "";
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        resourceURI     <- map["resourceURI"]
        name            <- map["name"]
    }
    
}
