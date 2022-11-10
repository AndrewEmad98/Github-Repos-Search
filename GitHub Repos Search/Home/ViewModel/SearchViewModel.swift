
import Foundation
import RxSwift
import RxCocoa

class SearchViewModel{
    
    //MARK: - properties
    private var disposeBag = DisposeBag()
    private var networkProvider: NetworkingProviderProtocol?
    
    init(networkProvider: NetworkingProviderProtocol){
        self.networkProvider = networkProvider
    }
    
    //MARK: - methods
    func searchGitHub(_ query: String) -> PublishRelay<[RepoViewData]>{
        // call the Api and get the data
        print("Hello Search binding")
        guard let networkProvider = networkProvider else {
            return PublishRelay<[RepoViewData]>()
        }
        return networkProvider.getRepos(query: query)
    }
    
}
