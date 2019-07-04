//
//  HeoresCollectionDao.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class HeoresCollectionDao: HeoresCollectionDataLocalSource{

    
    func insert(heroCollectionModels : [HeroCollectionModel]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            for hero in heroCollectionModels
            {
                realm.add(hero,update:true)
            }
            try realm.commitWrite()
        } catch (let error) {
            print(error)
        }
    }
    func fetch(withId:Int)-> [HeroCollectionModel]? {
        do {
            let realm = try Realm()
            return realm.objects(HeroCollectionModel.self).filter("id=%@", withId).itemsResltToArray()
            
        } catch (let error) {
            print(error)
            return nil
        }
    }

    
}

