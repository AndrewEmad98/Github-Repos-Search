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
    private let viewModel = HomeViewModel(networkProvider: MoyaNetworkManager.shared)
    private var disposeBag = DisposeBag()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindData()
    }
    private func setupUI(){
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
        searchController.searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .flatMapLatest { [weak self] query -> Observable<[RepoViewData]> in
                guard let self = self else { return .just([]) }
                if query.isEmpty {
                    return .just([])
                }
                //ProgressHUD.show()
                //ProgressHUD.dismiss()
                return self.viewModel.searchGitHub(query).catchAndReturn([])
            }
            .bind(to: tableView.rx.items(cellIdentifier: "RepoTableViewCell", cellType: RepoTableViewCell.self)){ row,element,cell in
                cell.cellSetup(repo: element)
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
}