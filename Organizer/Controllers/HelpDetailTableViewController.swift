//
//  HelpDetailTableViewController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 16.05.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit

class HelpDetailTableViewController: UIViewController {

    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postText: UITextView!
    
    var postObject: HelpPost!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        postTitle.text = postObject.title
        postText.text = postObject.text
        
    }
}
