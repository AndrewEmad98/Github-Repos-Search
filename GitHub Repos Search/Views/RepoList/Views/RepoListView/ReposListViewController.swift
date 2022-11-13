//
//  ReposListViewController.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 10/11/2022.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class ReposListViewController: UIViewController {

    //MARK: - properties
    private let tableView = UITableView()
    private let viewModel = SearchViewModel(networkProvider: MoyaNetworkManager.shared)
    private var disposeBag = DisposeBag()
    var query: String?
    
    
    //MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repositories"
        setupUI()
        bindData()
    }
    
    private func setupUI(){
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        tableView.frame = view.bounds
        tableView.backgroundColor = view.backgroundColor
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.refreshControl = UIRefreshControl()
        tableView.separatorColor = .lightGray
        tableView.allowsSelection = false
        view.addSubview(tableView)
    }
    
    private func bindData(){
        // table binding
        viewModel.query = query!
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "RepoTableViewCell", cellType: RepoTableViewCell.self)){ row,element,cell in
            cell.cellSetup(repo: element)
        }.disposed(by: disposeBag)

        // pagination binding
        tableView.rx.didScroll
            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.tableView.contentOffset.y
            let contentHeight = self.tableView.contentSize.height
            if offSetY > (contentHeight - self.tableView.frame.size.height){
                self.viewModel.getNewItems()
            }
        }.disposed(by: disposeBag)
        
        // loader pinding
        viewModel.loader.subscribe { data in
            if data.element ?? false {
                ProgressHUD.show()
            }else{
                ProgressHUD.dismiss()
            }
        }.disposed(by: disposeBag)
    }
}
