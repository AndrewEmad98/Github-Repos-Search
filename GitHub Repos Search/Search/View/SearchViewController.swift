//
//  ViewController.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 09/11/2022.
//

import UIKit

class SearchViewController: UIViewController {

    // properties
    private let searchController = UISearchController()
    private let viewModel = SearchViewModel<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // bind searchController to view model
    }
    private func setupUI(){
        navigationItem.searchController = searchController
    }
}


