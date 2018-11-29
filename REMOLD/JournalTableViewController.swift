//
//  JournalTableViewController.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 11/14/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

import UIKit
import PDFKit
import os.log

class JournalTableViewController: UITableViewController {
    
    var journals = [Journal]() // Collection of all Journals
    let dateFormatter = DateFormatter()
    
    // Unwinds from AddJournalViewController
    @IBAction func unwindtoJournalTableViewController (_ segue:UIStoryboardSegue) {
        
        if let sourceViewController = segue.source as? AddJournalViewController, let entry = sourceViewController.entry {
            
            let currentDate = Date()
            let newIndexPath = IndexPath(row: journals.count, section: 0)
            let journal = Journal(date: currentDate, entry: entry)
            journals.append(journal!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            // Save the meals.
            saveJournals()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Sets Date Format
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        // Loading samples for testing
        let test1 = Journal(date: dateFormatter.date(from: "JUN 06, 1970")!, entry: "test1")!
        let test2 = Journal(date: dateFormatter.date(from: "MAY 10, 2001")!, entry: "test2")!
        let test3 = Journal(date: dateFormatter.date(from: "DEC 29, 1775")!, entry: "test3")!
        
        journals += [test1, test2, test3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "JournalTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? JournalTableViewCell  else {
            fatalError("The dequeued cell is not an instance of JournalTableViewCell.")
        }
        
        // Fetches the appropriate one for the data source layout.
        let journal = journals[indexPath.row]
        
        cell.dateLabel.text = dateFormatter.string(from: journal.date)
        cell.entryField.text = journal.entry
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return journals.count
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            // Delete the row from the data source
            journals.remove(at: indexPath.row)
            saveJournals()
            tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
    
    
    
    
    
    
    @IBAction func ShareJournal(_ sender: UIBarButtonItem) {
    /*
        let journals: PDFDocument
        let vc = UIActivityViewController(activityItems: [journals], applicationActivities: [])
        present(vc, animated: true)
    */
    }
    
    private func saveJournals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(journals, toFile: Journal.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Journal successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save journal...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadJournals() -> [Journal]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Journal.ArchiveURL.path) as? [Journal]
    }
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
