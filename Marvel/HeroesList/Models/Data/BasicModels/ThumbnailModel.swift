//
//  ThumbnailModel.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class ThumbnailModel: Object,Mappable {
    
    @objc dynamic var path:String = "";
    @objc dynamic var exten:String = "";
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        path            <- map["path"]
        exten       <- map["extension"]

        
        
    }
    
}
