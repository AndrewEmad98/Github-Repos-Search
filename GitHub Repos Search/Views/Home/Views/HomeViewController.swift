//
//  ViewController.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 09/11/2022.
//

import UIKit
import RxSwift
import RxCocoa


class HomeViewController: BaseViewController{

    //MARK: - properties
    private let searchController = UISearchController()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bindData()
    }
    override func layout(){
        super.layout()
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
    }
    
    override func bindTableData(with observable: Observable<[RepoViewDataProtocol]>) {
        super.bindTableData(with: observable)
    }
    private func bindData(){
        // subscribe the table view to Api data depand on the search bar text
        let tableObservable = searchController.searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] query -> Observable<[RepoViewDataProtocol]> in
                guard let self = self else { return .just([]) }
                if query.isEmpty {
                    return .just([])
                }
                self.tableView.isHidden = false
                return self.viewModel.searchGitHub(query).catchAndReturn([])
            }
        bindTableData(with: tableObservable)
    }
    
}

//MARK: - search bar delegate methods
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        // navigate to next Page
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let repoListVC = storyBoard.instantiateViewController(withIdentifier: "RepoList") as? ReposListViewController {
            repoListVC.query = searchController.searchBar.text ?? ""
            navigationController?.pushViewController(repoListVC, animated: true)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // clear the results
        tableView.isHidden = true
    }
}
