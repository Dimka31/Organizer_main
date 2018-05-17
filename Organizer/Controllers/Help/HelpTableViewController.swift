//
//  HelpTableViewController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 15.05.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit
import Alamofire

class HelpTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var HelpTable: UITableView!
    
    var posts: [HelpPost] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request("http://mindfree.ru/ajax/org_news.php").responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success(let value):
                
                guard let jsonArray = value as? Array<[String: Any]> else { return }
                
                for jsonObject in jsonArray {
                    guard
                        let title = jsonObject["title"] as? String,
                        let text = jsonObject["text"] as? String
                        else {
                            return
                    }
                    let post = HelpPost(title: title, text: text)
                    self.posts.append(post)
                }
                
                self.HelpTable.reloadData()
                
            case .failure(let error):
                print(error)
            }
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
