//
//  NewTaskTableViewController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 24.03.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit

class NewTaskTableViewController: UIViewController {
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskText: UITextView!
    
    private var viewModel = TasksModelView() // лишняя подгрузка данных, переделать
    
    @IBAction func addNewTask(_ sender: UIButton) {
        
        if taskName.text!.isEmpty || taskText.text!.isEmpty {
            let alertController = UIAlertController(title: "Ошибка", message: "Не заполнены поля", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            if let title = self.taskName.text, let text = self.taskText.text {
                viewModel.addTask(title: title, text: text)
                performSegue(withIdentifier: "unwindToTasksController", sender: nil)
                
            } else {
                let alertController = UIAlertController(title: "Ошибка", message: "Произошла ошибка при сохранении данных", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                
                present(alertController, animated: true, completion: nil)
            }
        }
    }
}
