
import Foundation
import RxSwift
import RxCocoa

class SearchViewModel{
    
    //MARK: - properties
    private var disposeBag = DisposeBag()
    private var networkProvider: NetworkingProviderProtocol? = MoyaNetworkManager.shared
    private var loader = PublishSubject<Bool>()
    private var errorDetactor = PublishSubject<AppError>()
    var query: String?
    var pageNumber = 0
    private var itemsRelay = BehaviorRelay<[RepoViewDataProtocol]>(value: [])
    
    var itemsObservable: Observable<[RepoViewDataProtocol]>{
        return itemsRelay.asObservable()
    }
    var loaderObservable: Observable<Bool>{
        return loader.asObservable()
    }
    var errorDetactorObservable: Observable<AppError>{
        return errorDetactor.asObservable()
    }

    //MARK: - methods
    
    func searchGitHub(_ query: String,page: Int = 1) -> Observable<[RepoViewDataProtocol]>{
        guard let networkProvider = networkProvider else {
            return .just([])
        }
        loader.onNext(true)
        let observable = networkProvider.getRepos(query: query, page: page)
        observable.subscribe { [weak self] event in
            self?.loader.onNext(false)
            switch event{
            case .error(let error):
                let serverError = AppError.serverError(error.localizedDescription)
                self?.errorDetactor.onNext(serverError)
                self?.pageNumber -= 1
            default:
                break
            }
        }.disposed(by: disposeBag)
        return observable
    }
    
    func getNewItems(){
        pageNumber += 1
        let observable = searchGitHub(query!, page: pageNumber)
        observable.bind { [weak self] data in
            guard let self = self else{return}
            let newData = self.itemsRelay.value + data
            self.itemsRelay.accept(newData)
            self.loader.onNext(false)
        }.disposed(by: disposeBag)
    }
}
