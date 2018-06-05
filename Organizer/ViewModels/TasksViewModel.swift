//
//  TasksViewModel.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 05.06.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import Foundation
import RealmSwift

class TasksModelView {
    
    let realm = try! Realm()
    var tasksAr: Results<TasksEntity>!
    
    init() {
        tasksAr = realm.objects(TasksEntity.self)
    }
    
    func numberOfRows() -> Int {
        return tasksAr.count
    }
    
    func addTask(title: String, text: String) {
        try! self.realm.write {
            let newPlan = DailyPlansEntity()
            newPlan.text = text
            self.realm.add(newPlan)
        }
    }
    
    func editTask(task: TasksEntity, title: String, text: String) {
        try! realm.write {
            task.title = title
            task.text = text
        }
    }
    
    func deleteTask(indexPath: Int) {
        let listToBeDeleted = self.tasksAr[indexPath]
        
        try! self.realm.write({
            self.realm.delete(listToBeDeleted)
        })
    }
}
