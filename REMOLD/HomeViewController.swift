//
//  HomeViewController.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 10/10/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let quotes = ["Wanting to be someone else is a waste of who you are―Kurt Cobain", "There is no education like adversity. -Benjamin Disraeli", "You’re only here for a short visit. Don’t hurry, don’t worry. And be sure to smell the flowers along the way. -Walter Hagen","Life is a dance floor. So dance, don’t miss the chance. -Bar Refaeli","The good life is a process, not a state of being. It is a direction not a destination. -Carl Rogers"]
        print(quotes.randomElement()!)
     
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Gets a random quote from the database.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func buttonDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            sender.imageView!.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
    }
    
    @IBAction func buttonUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            sender.imageView!.transform = CGAffineTransform.identity
        })
    }
}
