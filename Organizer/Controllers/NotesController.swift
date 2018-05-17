//
//  ViewController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 04.03.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit
import RealmSwift

class NotesController: UIViewController, UITextViewDelegate {
    
    var noteObject: NotesEntity?
    let realm = try! Realm()

    @IBOutlet weak var MainTextarea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if realm.objects(NotesEntity.self).count == 0 {
            try! realm.write {
                let noteObject = NotesEntity()
                noteObject.text = "Вы можете писать заметки тут"
                realm.add(noteObject)
            }
        }
        
        noteObject = realm.objects(NotesEntity.self).first
       
        MainTextarea.text = noteObject?.text
        MainTextarea.delegate = self
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        try! realm.write { () -> Void in
            noteObject!.text = textView.text
        }
    }
}

