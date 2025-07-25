//
//  ViewController.swift
//  SearchBarWorkItem
//
//  Created by Alkit Gupta on 25/07/25.
//
import UIKit


class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    private let viewModel = UserSearchViewModel()
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "User Search"
        view.backgroundColor = .white
        
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        tableView.dataSource = self
        view.addSubview(tableView)
        
        // Layout
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        viewModel.onResultsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
      
        
        viewModel.onResultShowAlert = { [weak self] in
            let alert = UIAlertController(title: "Done", message: "Image uploaded.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchUsers(term: searchText)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.results[indexPath.row].name
        return cell
    }
    
   
    
}


