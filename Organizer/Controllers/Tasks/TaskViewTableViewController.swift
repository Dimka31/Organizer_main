//
//  TaskViewTableViewController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 27.03.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit

class TaskViewTableViewController: UIViewController {
    @IBOutlet weak var TaskTitle: UILabel!
    @IBOutlet weak var TaskText: UITextView!
    
    var taskObject: TasksEntity!
    
    @IBAction func uwingToViewTaskController(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToTaskViewController" else { return }
        
        let svc = segue.source as? EditTaskViewController
        taskObject = svc?.taskObject
                
        TaskTitle.text = taskObject.title
        TaskText.text = taskObject.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TaskTitle.text = taskObject.title
        TaskText.text = taskObject.text
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTaskSegue" {
           let dvc = segue.destination as! EditTaskViewController
            dvc.taskObject = self.taskObject
        }
    }


}
