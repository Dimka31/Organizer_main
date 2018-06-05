//
//  DailyPlans.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 04.06.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import Foundation
import RealmSwift

class DailyPlansModelView {
    
    let realm = try! Realm()
    var plansObjects: Results<DailyPlansEntity>!
    
    init() {
        plansObjects = realm.objects(DailyPlansEntity.self)
    }
    
    func numberOfRows() -> Int {
        return plansObjects.count
    }
    
    func addPlan(text: String) {
        try! self.realm.write {
            let newPlan = DailyPlansEntity()
            newPlan.text = text
            self.realm.add(newPlan)            
        }
    }
    
    func editPlan(indexPath: Int, text: String) {
        try! self.realm.write {
            self.plansObjects[indexPath].text = text
        }
    }
    
    func deletePlan(indexPath: Int) {
        let listToBeDeleted = self.plansObjects[indexPath]
        
        try! self.realm.write({ 
            self.realm.delete(listToBeDeleted)
        })
    }
}
