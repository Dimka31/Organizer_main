//
//  EditTaskViewController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 03.05.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    @IBOutlet weak var TaskNameEl: UITextField!
    @IBOutlet weak var TaskTextEl: UITextView!
    
    var taskObject: TasksEntity!
    private var viewModel = TasksModelView() // лишняя подгрузка данных, переделать
    
    @IBAction func SaveTask(_ sender: UIButton) {
        
        
        if let title = TaskNameEl.text, let text = TaskTextEl.text {
            viewModel.editTask(task: taskObject, title: title, text: text)
            performSegue(withIdentifier: "unwindSegueToTaskViewController", sender: nil)
        } else {
            let alertController = UIAlertController(title: "Ошибка", message: "Произошла ошибка при сохранении данных", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TaskNameEl.text = taskObject!.title
        TaskTextEl.text = taskObject!.text
    }
}
