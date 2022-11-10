//
//  ReposListViewController.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 10/11/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ReposListViewController: UIViewController {

    //MARK: - properties
    private let tableView = UITableView()
    private let viewModel = SearchViewModel(networkProvider: MoyaNetworkManager.shared)
    private var disposeBag = DisposeBag()
    var text: String?
    var pageNumber = 0
    
    //MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repositories"
        setupUI()
    }
    
    private func setupUI(){
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        tableView.frame = view.bounds
        tableView.backgroundColor = view.backgroundColor
        view.addSubview(tableView)
    }
    
    private func bindData(){
//        let searchResults = searchController.searchBar.rx.text.orEmpty
//            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .flatMapLatest { query -> Observable<[RepoViewData]> in
//                if query.isEmpty {
//                    return .just([])
//                }
//         //       return viewModel.searchGitHub(query).catchAndReturn([])
//                return .just([])
//            }.observe(on: MainScheduler.instance)
//        searchResults.bind(to: tableView.rx.items(cellIdentifier: "RepoTableViewCell", cellType: RepoTableViewCell.self)){ row,element,cell in
//            cell.cellSetup(repo: element)
//        }.disposed(by: disposeBag)
    }
}
