

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class BaseViewController: UIViewController,ErrorHandlerProtocol {
    

    //MARK: - Properties
    let viewModel = SearchViewModel()
    var disposeBag = DisposeBag()
    var tableView :UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        tableView.separatorColor = .lightGray
        tableView.allowsSelection = false
        return tableView
    }()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func layout(){
        tableView.frame = self.view.bounds
        tableView.backgroundColor = view.backgroundColor
        view.addSubview(tableView)
    }

    func bindTableData(with observable: Observable<[RepoViewDataProtocol]>){
        observable.bind(to: tableView.rx.items(cellIdentifier: "RepoTableViewCell", cellType: RepoTableViewCell.self)){row,element,cell in
            cell.cellSetup(repo: element)
        }.disposed(by: disposeBag)
        bindLoaderData()
        bindErrorHandler()
    }
    
    private func bindLoaderData(){
        viewModel.loaderObservable.subscribe { data in
            if data.element ?? false {
                ProgressHUD.show()
            }else{
                ProgressHUD.dismiss()
            }
        }.disposed(by: disposeBag)
    }
    
    private func bindErrorHandler(){
        viewModel.errorDetactorObservable.subscribe { [weak self] error in
            self?.makeUIErrorHandler(with: error.element?.errorDescription ?? "")
        }.disposed(by: disposeBag)
    }
    
    func makeUIErrorHandler(with message: String) {
        let alert = UIAlertController(title: "Error Happened", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
}
