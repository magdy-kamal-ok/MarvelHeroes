//
//  HeroModel.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class HeroModel: Object,Mappable {
    
    @objc dynamic var id:Int = 0;
    @objc dynamic var name:String = "";
    @objc dynamic var descriptions:String = "";
    @objc dynamic var modified:String = "";
    @objc dynamic var resourceURI:String = "";
    @objc dynamic var thumbnail:ThumbnailModel?
    @objc dynamic var comicModel:DetailsModel?
    @objc dynamic var seriesModel:DetailsModel?
    @objc dynamic var storiesModel:DetailsModel?
    @objc dynamic var eventsModel:DetailsModel?
    var urls : List<UrlModel> = List<UrlModel>()

    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id              <- map["id"]
        name            <- map["name"]
        descriptions    <- map["description"]
        modified        <- map["modified"]
        resourceURI     <- map["resourceURI"]
        thumbnail       <- map["thumbnail"]
        comicModel      <- map["comics"]
        seriesModel     <- map["series"]
        storiesModel    <- map["stories"]
        eventsModel     <- map["events"]
        urls            <- (map["urls"], ListTransform<UrlModel>())

        
    }
    override class func primaryKey() -> String? {
        return "id";
    }
}
