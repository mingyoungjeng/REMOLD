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
    let a = ["Name 5 objects in the room you are in right now.",
             "Name 5 countries from around the world.", "Name 5 car brands.",
             "Name 5 movies you like",
             "Name 5 celebrities you know.", "Name 5 colors"]
    
    @IBOutlet weak var button1: UIButton!
    @IBAction func button1(_ sender: UIButton) {
        print("\(button1.isSelected)")
        button1.isSelected = !button1.isSelected
        reset()
    }
    
    @IBOutlet weak var button2: UIButton!
    @IBAction func button2(_ sender: UIButton) {
        button2.isSelected = !button2.isSelected
        reset()
    }
    @IBOutlet weak var button3: UIButton!
    @IBAction func button3(_ sender: UIButton) {
        button3.isSelected = !button3.isSelected
        reset()
    }
    @IBOutlet weak var button4: UIButton!
    @IBAction func button4(_ sender: UIButton) {
        button4.isSelected = !button4.isSelected
        reset()
    }
    @IBOutlet weak var button5: UIButton!
    @IBAction func button5(_ sender: UIButton) {
        button5.isSelected = !button5.isSelected
        reset()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        textField.text = a.randomElement()
        
    

            }
   func reset() {
    
    if button5.isSelected && button4.isSelected && button3.isSelected && button2.isSelected && button1.isSelected{
        button1.isSelected = false
        button2.isSelected = false
        button3.isSelected = false
        button4.isSelected = false
        button5.isSelected = false
        textField.text = a.randomElement()
        
    }
}

        // Do any additional setup after loading the view
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
