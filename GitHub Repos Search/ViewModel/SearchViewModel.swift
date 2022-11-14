
import Foundation
import RxSwift
import RxCocoa

class SearchViewModel{
    
    //MARK: - properties
    private var disposeBag = DisposeBag()
    private var networkProvider: NetworkingProviderProtocol?
    var loader = PublishSubject<Bool>()
    var errorDetactor = PublishSubject<AppError>()
    var items = BehaviorRelay<[RepoViewData]>(value: [])
    var query: String?
    var pageNumber = 0
    
    init(networkProvider: NetworkingProviderProtocol){
        self.networkProvider = networkProvider
    }
    
    //MARK: - methods
    
    func searchGitHub(_ query: String,page: Int = 1) -> Observable<[RepoViewData]>{
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
        loader.onNext(true)
        let observable = searchGitHub(query!, page: pageNumber)
        observable.bind { [weak self] data in
            guard let self = self else{return}
            let newData = self.items.value + data
            self.items.accept(newData)
            self.loader.onNext(false)
        }.disposed(by: disposeBag)
    }
}
