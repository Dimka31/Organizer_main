//
//  NewTaskTableViewController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 24.03.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit
import RealmSwift

class NewTaskTableViewController: UIViewController {
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskText: UITextView!
    
    @IBAction func addNewTask(_ sender: UIButton) {
        
        if taskName.text!.isEmpty || taskText.text!.isEmpty {
            let alertController = UIAlertController(title: "Ошибка", message: "Не заполнены поля", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            let realm = try! Realm()
            
            try! realm.write {
                let newTask = TasksEntity()
                
                newTask.title = self.taskName.text!
                newTask.text = self.taskText.text
                
                realm.add(newTask)
            }
            
            performSegue(withIdentifier: "unwindToTasksController", sender: nil)
        }
    }
}
