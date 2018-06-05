//
//  Notes.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 04.06.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import Foundation
import RealmSwift

class Notes {
    
    let realm = try! Realm()
    var noteObject: NotesEntity!
    var text: String!
    
    init() {
        if realm.objects(NotesEntity.self).count == 0 {
            try! realm.write {
                noteObject = NotesEntity()
                noteObject.text = "Вы можете писать заметки тут"
                realm.add(noteObject)
            }
        }
        
        noteObject = realm.objects(NotesEntity.self).first
        self.text = noteObject.text
    }
    
    
    func save(text: String) {
        try! realm.write { 
            noteObject.text = text
        }
    }
}
