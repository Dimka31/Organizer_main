//
//  TasksController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 22.03.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit

class TasksController: UIViewController, UITableViewDelegate, UITableViewDataSource     {
    @IBOutlet weak var TasksTable: UITableView!
    
    private var viewModel = TasksModelView()
    
    
    @IBAction func uwingToTaskController(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToTasksController" else { return }
        
        TasksTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskTableViewCell
        
        cell.taskTitle.text = viewModel.tasksAr[indexPath.row].title
        cell.taskText.text = viewModel.tasksAr[indexPath.row].text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasksAr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.deleteTask(indexPath: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewTaskSegue" {
            if let indexPath = TasksTable.indexPathForSelectedRow {
                let dvc = segue.destination as! TaskViewTableViewController
                dvc.taskObject = viewModel.tasksAr[indexPath.row]
            }
        }
    }
}
