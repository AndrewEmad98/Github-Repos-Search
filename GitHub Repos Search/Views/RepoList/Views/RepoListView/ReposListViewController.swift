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

class ReposListViewController: BaseViewController {

    //MARK: - properties

    var query: String?
    
    
    //MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repositories"
        super.layout()
        bindData()
    }

    private func bindData(){
        // table binding
        viewModel.query = query!
        super.bindTableData(with: viewModel.itemsObservable)

        // pagination binding
        tableView.rx.didScroll
            .throttle(.milliseconds(2000), scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.tableView.contentOffset.y
            let contentHeight = self.tableView.contentSize.height
            if offSetY > (contentHeight - self.tableView.frame.size.height){
                self.viewModel.getNewItems()
            }
        }.disposed(by: disposeBag)

    }
    
}
