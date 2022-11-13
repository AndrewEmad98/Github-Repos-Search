
import Foundation
import RxSwift
import RxCocoa

class HomeViewModel{
    
    //MARK: - properties
    private var disposeBag = DisposeBag()
    private var networkProvider: NetworkingProviderProtocol?
    private var reposData = PublishSubject<[RepoViewData]>()
    var loader = PublishSubject<Bool>()
    var items = BehaviorRelay<[RepoViewData]>(value: [])
    var query: String?
    var pageNumber = 0
    
    init(networkProvider: NetworkingProviderProtocol){
        self.networkProvider = networkProvider
    }
    
    //MARK: - methods
    func searchGitHub(_ query: String,page: Int = 1) -> Observable<[RepoViewData]>{
        guard let networkProvider = networkProvider else {
            return reposData
        }
        loader.onNext(true)
        let observable = networkProvider.getRepos(query: query, page: page)
        observable.subscribe { [weak self] _ in
            self?.loader.onNext(false)
        }.disposed(by: disposeBag)
        return observable
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
