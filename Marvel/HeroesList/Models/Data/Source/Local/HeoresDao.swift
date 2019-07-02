//
//  HeoresDao.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class HeoresDao<R:Object>: HeroesDataLocalSource{
    
    func insert(heroesResponseModel : R) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(heroesResponseModel,update:true)
            try realm.commitWrite()
        } catch (let error) {
            print(error)
        }
    }

    func fetch()->R? {
        do {
            let realm = try  Realm()
            return realm.objects(R.self).first
        } catch (let error) {
            print(error)
            return nil
        }
    }
    func fetch(withOffset:Int)-> R? {
        do {
            let realm = try  Realm()
            return realm.objects(R.self).filter("offset=%@", withOffset).first
            
        } catch (let error) {
            print(error)
            return nil
        }
    }
    
    func fetchArray()->[R]? {
        do {
            let realm = try  Realm()
            return realm.objects(R.self).itemsResltToArray()
        } catch (let error) {
            print(error)
            return nil
        }
    }
    
    func delete(){
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.delete(realm.objects(R.self))
            try realm.commitWrite()
        } catch (let error) {
            print(error)
        }
    }
}

