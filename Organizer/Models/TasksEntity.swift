//
//  TasksEntity.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 25.03.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import Foundation
import RealmSwift

class TasksEntity: Object {
    @objc dynamic var taskId = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var text = ""
    @objc dynamic var status = "новая"
    @objc dynamic var created = NSDate()
    
    override static func primaryKey() -> String? {
        return "taskId"
    }
}
