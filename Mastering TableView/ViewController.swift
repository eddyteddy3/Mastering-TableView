//
//  ViewController.swift
//  Mastering TableView
//
//  Created by Moazzam Tahir on 03/08/2019.
//  Copyright © 2019 Moazzam Tahir. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var spaceArray = [String]()
    var imageArr = [String]()
    var webAddresses = [String]()
    
    var searchResults = [Int]()
    var isPerformingResults: Bool?
    let searchbar = UISearchController(searchResultsController: nil) //because we are not using another view controller for search bar.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initilizer()
    }
    
    func initilizer() {
        
        spaceArray = ["Nebula", "Black Holes", "Milky Way", "Northern Lights", "Constellation"]
        
        imageArr = ["buckingham_palace", "eiffel_tower", "empire_state_building", "grand_canyon", "windsor_castle"]
        webAddresses = ["https://en.wikipedia.org/wiki/Buckingham_Palace","https://en.wikipedia.org/wiki/Eiffel_Tower","https://en.wikipedia.org/wiki/Grand_Canyon","https://en.wikipedia.org/wiki/Windsor_Castle","https://en.wikipedia.org/wiki/Empire_State_Building"]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.estimatedRowHeight = 100
        
        searchbar.searchBar.delegate = self
        searchbar.searchResultsUpdater = self
        searchbar.obscuresBackgroundDuringPresentation = false
        searchbar.searchBar.placeholder = "Search Attractions"
        navigationItem.searchController = searchbar
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchbar.searchBar.text, !searchText.isEmpty {
            searchResults.removeAll()
            
            for index in 0..<spaceArray.count {
                if spaceArray[index].lowercased().contains(searchText.lowercased()) {
                    searchResults.append(index)
                }
            }
            isPerformingResults = true
        } else {
            isPerformingResults = false
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isPerformingResults! ? searchResults.count : spaceArray.count
    }
    
    //This function is used for for swipe to delete the row.
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let configuration = UISwipeActionsConfiguration(actions: [UIContextualAction(style: .normal, title: "Delete", handler: { (action, view, completionHandler) in
            
            let row = indexPath.row
            
            self.spaceArray.remove(at: row) //removing the specific row
            self.imageArr.remove(at: row) //removing the corresponding image of that row
            
            view.backgroundColor = .blue
            action.backgroundColor = .blue
            
            completionHandler(true)
            tableView.reloadData()
            
        })])
        
        return configuration
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        
        let row = indexPath.row
        
        cell.textLabel?.text = spaceArray[row]
        cell.imageView?.image = UIImage(named: imageArr[row])
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailedView" {
            let destinedVC = segue.destination as! DetailedViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let row = indexPath.row
            
            destinedVC.urlString = webAddresses[row]
            destinedVC.navTitle = spaceArray[row]
        }
    }


}

