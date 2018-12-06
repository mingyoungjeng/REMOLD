//
//  GamesViewController.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 10/10/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    let a = ["Name 5 objects in the room you are in right now.",
             "Name 5 countries from around the world.", "Name 5 car brands.",
             "Name 5 movies you like",
             "Name 5 celebrities you know.", "Name 5 colors"]
    
    @IBAction func buttonSelector(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if button5.isSelected && button4.isSelected && button3.isSelected && button2.isSelected && button1.isSelected {
            
            button1.isSelected = false
            button2.isSelected = false
            button3.isSelected = false
            button4.isSelected = false
            button5.isSelected = false
            textField.text = a.randomElement()
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        textField.text = a.randomElement()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
