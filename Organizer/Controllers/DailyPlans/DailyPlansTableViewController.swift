//
//  DailyPlansTableViewController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 07.05.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit
import RealmSwift

class DailyPlansTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var plansTableView: UITableView!
    
    var plansObjects: Results<DailyPlansEntity>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.plansObjects = realm.objects(DailyPlansEntity.self)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.plansObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell")
        
        cell?.textLabel?.text = plansObjects![indexPath.row].text
        
        return cell!
    }
    
    @IBAction func addPlan(_ sender: Any) {
        let alertController = UIAlertController(title: "Добавить задачу", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }
            
            try! self.realm.write {
                let newPlan = DailyPlansEntity()
                newPlan.text = textField.text!
                self.realm.add(newPlan)
                
                self.plansTableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .default, handler: nil)
        alertController.addTextField()
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editing = UITableViewRowAction(style: .default, title: "изменить") { (action, indexPath) in
            
            let alertController = UIAlertController(title: "Редактировать задачу", message: "", preferredStyle: .alert)
            
            let addAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
                guard let textField = alertController.textFields?.first, textField.text != "" else { return }
                
                try! self.realm.write {
                    self.plansObjects![indexPath.row].text = textField.text!
                    self.plansTableView.reloadData()
                }
            }
            let cancelAction = UIAlertAction(title: "Отменить", style: .default, handler: nil)
            alertController.addTextField()
            alertController.textFields?.first?.text = self.plansObjects![indexPath.row].text
            alertController.addAction(addAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "удалить") { (action, indexPath) in
            let listToBeDeleted = self.plansObjects![indexPath.row]
            
            try! self.realm.write({ () -> Void in
                self.realm.delete(listToBeDeleted)
                tableView.reloadData()
            })
        }
        
        editing.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        return [delete, editing]
    }
    

}
