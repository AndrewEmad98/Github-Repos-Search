//
//  ViewController.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 09/11/2022.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell") as! RepoTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    // properties
    private let searchController = UISearchController()
    private let tableView = UITableView()
    private let viewModel = SearchViewModel<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // bind searchController to view model
    }
    private func setupUI(){
        navigationItem.searchController = searchController
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        tableView.frame = view.bounds
        tableView.backgroundColor = view.backgroundColor
        view.addSubview(tableView)
        tableView.indicatorStyle = .white
        tableView.dataSource = self
    }
}


