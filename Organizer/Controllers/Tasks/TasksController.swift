//
//  TasksController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 22.03.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit
import RealmSwift

class TasksController: UIViewController, UITableViewDelegate, UITableViewDataSource	 {
    @IBOutlet weak var TasksTable: UITableView!
    
    var tasksAr: Results<TasksEntity>?
    let realm = try! Realm()
    
    @IBAction func uwingToTaskController(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToTasksController" else { return }
        
        tasksAr = realm.objects(TasksEntity.self)
        TasksTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksAr = realm.objects(TasksEntity.self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskTableViewCell
        
        cell.taskTitle.text = tasksAr![indexPath.row].title
        cell.taskText.text = tasksAr![indexPath.row].text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksAr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let listToBeDeleted = self.tasksAr![indexPath.row]

            try! realm.write({ () -> Void in
                realm.delete(listToBeDeleted)
                tableView.reloadData()
            })
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewTaskSegue" {
            if let indexPath = TasksTable.indexPathForSelectedRow {
                let dvc = segue.destination as! TaskViewTableViewController
                dvc.taskObject = tasksAr![indexPath.row]
            }
        }
    }
}
