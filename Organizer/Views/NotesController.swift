//
//  ViewController.swift
//  Organizer
//
//  Created by Dmitry Rakhmankulov on 04.03.2018.
//  Copyright © 2018 Dmitry Rakhmankulov. All rights reserved.
//

import UIKit

class NotesController: UIViewController, UITextViewDelegate {
    
    private var viewModel = Notes()

    @IBOutlet weak var MainTextarea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainTextarea.text = viewModel.text
        MainTextarea.delegate = self
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let text = textView.text {
            viewModel.save(text: text)
        }
    }
}

