//
//  EditTaskViewController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 03.05.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit
import RealmSwift

class EditTaskViewController: UIViewController {
    
    @IBOutlet weak var TaskNameEl: UITextField!
    @IBOutlet weak var TaskTextEl: UITextView!
    
    var taskObject: TasksEntity?
    
    @IBAction func SaveTask(_ sender: UIButton) {
        
        let realm = try! Realm()
        try! realm.write { () -> Void in
            taskObject!.title = TaskNameEl.text!
            taskObject!.text = TaskTextEl.text!
        }
        
        performSegue(withIdentifier: "unwindSegueToTaskViewController", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TaskNameEl.text = taskObject!.title
        TaskTextEl.text = taskObject!.text
    }
}
