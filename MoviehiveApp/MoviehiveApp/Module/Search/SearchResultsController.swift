//
//  SearchResultsController.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 29.04.2022.
//

import UIKit
import MoviehiveAPI

protocol SearchResultsControllerProtocol: AnyObject {
    func reloadData()
    func setView()
}

class SearchResultsController: UITableViewController{
    
    var presenter: SearchResultsPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter.numberOfMovies
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter.searchedMovie(index: indexPath.row)?.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
}

extension SearchResultsController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchtext = searchController.searchBar.text!
        presenter.updateResults(query: searchtext)
    
    }
    
}

extension SearchResultsController: SearchResultsControllerProtocol {
    func setView() {
        tableView.backgroundColor = .clear
        definesPresentationContext = true
        
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    
}
