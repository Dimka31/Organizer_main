//
//  HelpTableViewController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 15.05.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit

class HelpTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var HelpTable: UITableView!
    
    var posts: [HelpPost] = []
    private var viewModel = HelpModelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts = viewModel.getHelp {
            self.HelpTable.reloadData()
        }
        
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "helpCell")
        
        cell?.textLabel?.text = posts[indexPath.row].title
        cell?.detailTextLabel?.text = posts[indexPath.row].text
        
        return cell!
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsDetailSegue" {
            if let indexPath = HelpTable.indexPathForSelectedRow {
                let dvc = segue.destination as! HelpDetailTableViewController
                dvc.postObject = posts[indexPath.row]
            }
        }
    }
    
}
