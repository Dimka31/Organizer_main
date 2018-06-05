//
//  DailyPlansTableViewController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 07.05.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit

class DailyPlansTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var plansTableView: UITableView!
    private var viewModel = DailyPlansModelView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell")
        guard let tableViewCell = cell else { return UITableViewCell() }
        
        tableViewCell.textLabel?.text = viewModel.plansObjects[indexPath.row].text
        
        return tableViewCell
    }
    
    @IBAction func addPlan(_ sender: Any) {
        let alertController = UIAlertController(title: "Добавить задачу", message: "", preferredStyle: .alert)
        
        alertController.addTextField()
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }
            
            if let text = textField.text {
                self.viewModel.addPlan(text: text)
                self.plansTableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .default, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editing = UITableViewRowAction(style: .default, title: "изменить") { (action, indexPath) in
            
            let alertController = UIAlertController(title: "Редактировать задачу", message: "", preferredStyle: .alert)
            
            let addAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
                guard let textField = alertController.textFields?.first, textField.text != "" else { return }
                
                if let text = textField.text {
                    self.viewModel.editPlan(indexPath: indexPath.row, text: text)
                    self.plansTableView.reloadData()
                }
            }
            let cancelAction = UIAlertAction(title: "Отменить", style: .default, handler: nil)
            alertController.addTextField()
            alertController.textFields?.first?.text = self.viewModel.plansObjects[indexPath.row].text
            alertController.addAction(addAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "удалить") { (action, indexPath) in           
            self.viewModel.deletePlan(indexPath: indexPath.row)
            self.plansTableView.reloadData()
        }
        
        editing.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        return [delete, editing]
    }
    

}
