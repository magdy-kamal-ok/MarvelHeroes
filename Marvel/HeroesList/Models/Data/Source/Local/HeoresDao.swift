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

class HeoresDao: HeroesDataLocalSource{

    
    func insert(heroesResponseModel : HeroesListModel) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(heroesResponseModel,update:true)
            try realm.commitWrite()
        } catch (let error) {
            print(error)
        }
    }

    func fetch()->HeroesListModel? {
        do {
            let realm = try  Realm()
            return realm.objects(HeroesListModel.self).first
        } catch (let error) {
            print(error)
            return nil
        }
    }
    func fetch(withOffset:Int)-> HeroesListModel? {
        do {
            let realm = try Realm()
            return realm.objects(HeroesListModel.self).filter("offset=%@", withOffset).first
            
        } catch (let error) {
            print(error)
            return nil
        }
    }
    
    func fetchArray()->[HeroesListModel]? {
        do {
            let realm = try  Realm()
            return realm.objects(HeroesListModel.self).itemsResltToArray()
        } catch (let error) {
            print(error)
            return nil
        }
    }
    
    func delete(){
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.delete(realm.objects(HeroesListModel.self))
            try realm.commitWrite()
        } catch (let error) {
            print(error)
        }
    }
    func searchBy(name: String)->[HeroModel]? {
        do {
            let realm = try Realm()
            return realm.objects(HeroModel.self).filter("name == %@", name).itemsResltToArray()
            

        } catch (let error) {
            print(error)
            return nil
        }
    }
    
}

