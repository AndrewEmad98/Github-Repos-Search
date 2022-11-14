//
//  ViewController.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 09/11/2022.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class HomeViewController: UIViewController{

    //MARK: - properties
    private let searchController = UISearchController()
    private let tableView = UITableView()
    private let viewModel = SearchViewModel(networkProvider: MoyaNetworkManager.shared)
    private var disposeBag = DisposeBag()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bindData()
    }
    private func layout(){
        navigationItem.searchController = searchController
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        tableView.frame = view.bounds
        tableView.backgroundColor = view.backgroundColor
        tableView.separatorColor = .lightGray
        tableView.allowsSelection = false
        view.addSubview(tableView)
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
    }
    private func bindData(){
        
        // subscribe the table view to Api data depand on the search bar text
        searchController.searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] query -> Observable<[RepoViewData]> in
                guard let self = self else { return .just([]) }
                if query.isEmpty {
                    return .just([])
                }
                self.tableView.isHidden = false
                return self.viewModel.searchGitHub(query).catchAndReturn([])
            }
            .bind(to: tableView.rx.items(cellIdentifier: "RepoTableViewCell", cellType: RepoTableViewCell.self)){ row,element,cell in
                cell.cellSetup(repo: element)
            }.disposed(by: disposeBag)
        
        viewModel.loader.subscribe { data in
            if data.element ?? false {
                ProgressHUD.show()
            }else{
                ProgressHUD.dismiss()
            }
        }.disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetails"{
            if let destination = segue.destination as? ReposListViewController {
                destination.query = searchController.searchBar.text ?? ""
            }
        }
    }
}

//MARK: - search bar delegate methods
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        // navigate to next Page
        performSegue(withIdentifier: "GoToDetails", sender: self)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // clear the results
        tableView.isHidden = true
    }
}
