//
//  LiberationsViewController.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 10/10/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

import UIKit

class LiberationsViewController: UITableViewController {

    let quotes = ["Wanting to be someone else is a waste of who you are \n-Kurt Cobain", "There is no education like adversity. \n-Benjamin Disraeli", "You’re only here for a short visit. Don’t hurry, don’t worry. And be sure to smell the flowers along the way. \n-Walter Hagen","Life is a dance floor. So dance, don’t miss the chance. \n-Bar Refaeli","The good life is a process, not a state of being. It is a direction not a destination. \n-Carl Rogers"]
    var quotes_f = [String]()
    var docController: UIDocumentInteractionController!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Quotes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return quotes_f.count
        }
        
        return quotes.count
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "LiberationsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LiberationsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of JournalTableViewCell.")
        }
        
        // Fetches the appropriate one for the data source layout.
        let quote = isFiltering() ? quotes_f[indexPath.row] : quotes[indexPath.row]
        
        cell.Label.text = quote
        
        return cell
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
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        quotes_f = quotes.filter({( quote : String) -> Bool in
            return quote.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
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

extension LiberationsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
