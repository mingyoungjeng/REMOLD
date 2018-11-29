//
//  AddJournalViewController.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 11/14/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

import UIKit
import os.log

class AddJournalViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var inited = false
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var entry: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        entry = textView.text
    }
    
}

extension AddJournalViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (inited == false) {
            textView.text = ""
            inited = true
        }
    }
}
