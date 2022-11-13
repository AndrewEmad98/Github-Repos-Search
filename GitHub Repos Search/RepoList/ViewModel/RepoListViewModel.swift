import Foundation
import RxSwift
import RxCocoa

class RepoListViewModel{
    
    //MARK: - properties
    private var disposeBag = DisposeBag()
    private var networkProvider: NetworkingProviderProtocol?
    var items = BehaviorRelay<[RepoViewData]>(value: [])
    var query: String?
    var pageNumber = 0
    init(networkProvider: NetworkingProviderProtocol){
        self.networkProvider = networkProvider
    }
    
    //MARK: - methods
    private func searchGitHub(_ query: String,page: Int = 1)-> Observable<[RepoViewData]> {
        guard let networkProvider = networkProvider else {
            return .just([])
        }
        return networkProvider.getRepos(query: query, page: pageNumber)
    }
    func getNewItems(){
        pageNumber += 1
        print(pageNumber)
        let observable = searchGitHub(query!, page: pageNumber)
        observable.bind { [weak self] data in
            guard let self = self else{return}
            let newData = self.items.value + data
            self.items.accept(newData)
        }.disposed(by: disposeBag)
    }
}

