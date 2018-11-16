//
//  AddJournalViewController.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 11/14/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

import UIKit

class AddJournalViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var inited = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Save(_ sender: UIBarButtonItem) {
        print(textView.text!)
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
