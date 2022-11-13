
import Foundation
import RxSwift
import RxCocoa

class HomeViewModel{
    
    //MARK: - properties
    private var disposeBag = DisposeBag()
    private var networkProvider: NetworkingProviderProtocol?
    private var reposData = PublishSubject<[RepoViewData]>()

    init(networkProvider: NetworkingProviderProtocol){
        self.networkProvider = networkProvider
    }
    
    //MARK: - methods
    func searchGitHub(_ query: String,page: Int = 1) -> Observable<[RepoViewData]>{
        guard let networkProvider = networkProvider else {
            return reposData
        }
        return networkProvider.getRepos(query: query, page: page)
    }
}
