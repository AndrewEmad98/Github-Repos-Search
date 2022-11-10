//
//  ViewController.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 09/11/2022.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController{

    // properties
    private let searchController = UISearchController()
    private let tableView = UITableView()
    private let viewModel = SearchViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // bind searchController Text to view model
        bindData()
    }
    private func setupUI(){
        navigationItem.searchController = searchController
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        tableView.frame = view.bounds
        tableView.backgroundColor = view.backgroundColor
        view.addSubview(tableView)
        searchController.searchBar.delegate = self
    }
    private func bindData(){
        let searchResults = searchController.searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[RepoViewData]> in
                if query.isEmpty {
                    return .just([])
                }
         //       return viewModel.searchGitHub(query).catchAndReturn([])
                return .just([])
            }.observe(on: MainScheduler.instance)
        searchResults.bind(to: tableView.rx.items(cellIdentifier: "RepoTableViewCell", cellType: RepoTableViewCell.self)){ row,element,cell in
            cell.cellSetup(repo: element)
        }.disposed(by: disposeBag)
    }
}

//MARK: - search bar delegate methods
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        // navigate to next Page
        performSegue(withIdentifier: "GoToDetails", sender: self)
    }
}
