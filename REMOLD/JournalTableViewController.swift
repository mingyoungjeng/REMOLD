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
	var journals_f = [Journal]()
    let dateFormatter = DateFormatter()
	var docController: UIDocumentInteractionController!
	let searchController = UISearchController(searchResultsController: nil)
    
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
        dateFormatter.dateFormat = "MMMM d, yyyy"
		
		if let savedJournals = loadJournals() {
			journals += savedJournals
		}
		
		// Setup the Search Controller
		searchController.searchResultsUpdater = self as UISearchResultsUpdating
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search Journals"
		navigationItem.searchController = searchController
		definesPresentationContext = true
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
		let journal = isFiltering() ? journals_f[indexPath.row] : journals[indexPath.row]
        
        cell.dateLabel.text = dateFormatter.string(from: journal.date)
        cell.entryField.text = journal.entry
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		if isFiltering() {
			return journals_f.count
		}
		
		return journals.count
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            // Delete the row from the data source
            journals.remove(at: indexPath.row)
            saveJournals()
            tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView.rowHeight
    }
    
	func isFiltering() -> Bool {
		return searchController.isActive && !searchBarIsEmpty()
	}
	
	func searchBarIsEmpty() -> Bool {
		// Returns true if the text is empty or nil
		return searchController.searchBar.text?.isEmpty ?? true
	}
    
    
    @IBAction func ShareJournal(_ sender: UIBarButtonItem) {
        
        // 1. Create a print formatter
        
		var html = "" // create some text as the body of the PDF with html.
		
		for i in journals {
			html += "<h2>\(dateFormatter.string(from: i.date))</h2><h4>\(i.entry)</h4><br>"
		}
		
        
        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect
        
        let page = CGRect(x: 10, y: 10, width: 595.2, height: 841.8) // A4, 72 dpi, x and y are horizontal and vertical margins
        let printable = page.insetBy(dx: 0, dy: 0)
        
        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
        
        // 4. Create PDF context and draw
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
        
        for i in 1...render.numberOfPages {
            
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }
        
        UIGraphicsEndPDFContext();
        
        // 5. Save PDF file
        
        let path = "\(NSTemporaryDirectory())Journals.pdf"
        pdfData.write(toFile: path, atomically: true)
        print("open \(path)") // check if we got the path right.
        // open share dialog
        print("opening share dialog")
        // Initialize Document Interaction Controller
        docController = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
        // Configure Document Interaction Controller
		docController.delegate = self as? UIDocumentInteractionControllerDelegate
        // Present Open In Menu
        docController.presentOptionsMenu(from: sender, animated: true) // create an outlet from an Export bar button outlet, then use it as the `from` argument
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
	
	func filterContentForSearchText(_ searchText: String, scope: String = "All") {
		journals_f = journals.filter({( journal : Journal) -> Bool in
			return journal.entry.lowercased().contains(searchText.lowercased())
		})
		
		tableView.reloadData()
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

extension JournalTableViewController: UISearchResultsUpdating {
	// MARK: - UISearchResultsUpdating Delegate
	func updateSearchResults(for searchController: UISearchController) {
		filterContentForSearchText(searchController.searchBar.text!)
	}
}
