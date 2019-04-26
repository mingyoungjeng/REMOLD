//
//  LiberationsViewController.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 10/10/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

import UIKit

class LiberationsViewController: UITableViewController {

    let quotes = ["Wanting to be someone else is a waste of who you are \n-Kurt Cobain", "There is no education like adversity. \n-Benjamin Disraeli", "You’re only here for a short visit. Don’t hurry, don’t worry. And be sure to smell the flowers along the way. \n-Walter Hagen","Life is a dance floor. So dance, don’t miss the chance. \n-Bar Refaeli","The good life is a process, not a state of being. It is a direction not a destination. \n-Carl Rogers","The good life is a process, not a state of being. It is a direction not a destination. -Carl Rogers","Life is a lively process of becoming. -Douglas MacArthur","Life is wide, limitless. There is no border, no frontier. -Bruce Lee","The tragedy of life is what dies inside a man while he lives. -Albert Schweitzer","Reverence for life is the highest court of appeal. -Albert Schweitzer","The purpose of human life is to serve and to show compassion and the will to help others. -Albert Schweitzer","The meaning of life is that it is to be lived, and it is not be traded and conceptualized and squeezed into a pattern of systems. -Bruce Lee","To live is to express, and to express, you have to create. Creation is never merely repetition. To live is to express oneself freely in creation. -Bruce Lee","Life is beautiful because it doesn’t last. -Brit Marling","Life is too short to be little. Man is never so manly as when he feels deeply, acts boldly, and expresses himself with frankness and with fervor. -Benjamin Disraeli","Life is a dance floor. So dance, don’t miss the chance. -Bar Refaeli","Life is a gift, given in trust – like a child. -Anne Morrow Lindbergh","Life is like a box of sardines and we are all looking for the key. -Alan Bennett","Life is too mysterious to try to map it out. I’ve certainly lived long enough to know it will take you places you never thought it would take you – and some of those places are kind of wonderful. -Alan Ball","Life is an ever-flowing process and somewhere on the path some unpleasant things will pop up – it might leave a scar, but then life is flowing, and like running water, when it stops it grows stale. Go bravely on, my friend, because each experience teaches us a lesson. Keep blasting because life is such that sometimes it is nice and sometimes it is not. -Bruce Lee","Life is a process of becoming, a combination of states we have to go through. Where people fail is that they wish to elect a state and remain in it. This is a kind of death. -Anais Nin","Life is a mixing of all kind of things: comedy and tragedy going together. -Alejandro Jodorowsky"]
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
