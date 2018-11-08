//
//  ResourcesTableViewController.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 11/8/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

import UIKit

class ResourcesTableViewController: UITableViewController {
    
    struct Resource {
        var name: String
        var url: URL
        var phone: URL
    }
    var resources = [Resource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resources += [
            Resource(name: "National Alliance on Mental Illness", url: URL(string: "https://www.nami.org")!, phone: URL(string: "tel://18009506264")!),
            /*Resource(name: "Anxiety and Depression Association of America", url: URL(string: "http://treatment.adaa.org")!),
            Resource(name: "National Institute of Mental Health", url: URL(string: "https://www.nimh.nih.gov")!),
            Resource(name: "Suicide Prevention Lifeline", url: URL(string: "http://www.suicidepreventionlifeline.org")!)*/
        ]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ResourcesTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ResourcesTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ResourcesTableViewCell.")
        }

        let resource = resources[indexPath.row]
        cell.Label.text = resource.name
        cell.link = resource.url
        cell.number = resource.phone
        

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
