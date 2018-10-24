//
//  ResourcesViewController.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 10/9/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

import UIKit

class ResourcesViewController: UIViewController {

    var NAMI_URL = URL(string: "https://www.nami.org")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func topButton(_ sender: UIButton) {
        UIApplication.shared.open(NAMI_URL!, options: [:])
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
