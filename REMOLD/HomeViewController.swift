//
//  HomeViewController.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 10/10/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	let a = ["“You are imperfect, permanently and inevitably flawed. And you are beautiful.”\n-Amy Bloom",
			 "“You yourself, as much as anybody in the entire universe, deserve your love and affection”\n― Sharon Salzberg", "“Wanting to be someone else is a waste of the person you are.“\n― Marilyn Monroe",
			 "“The worst loneliness is to not be comfortable with yourself.“\n― Mark Twain","“Peace comes from within.Do not seek it without.“\n― Siddhārtha Gautama"]
    @IBOutlet weak var quotes: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
		
     
        // Do any additional setup after loading the view.
		quotes.text = a.randomElement();
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
			self.quotes.text = self.a.randomElement()
        })
    }
}
