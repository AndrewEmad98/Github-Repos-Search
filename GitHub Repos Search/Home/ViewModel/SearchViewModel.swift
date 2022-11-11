
import Foundation
import RxSwift
import RxCocoa

class SearchViewModel{
    
    //MARK: - properties
    private var disposeBag = DisposeBag()
    private var networkProvider: NetworkingProviderProtocol?
    private var reposData = BehaviorSubject<[RepoViewData]>(value: [])
    
    init(networkProvider: NetworkingProviderProtocol){
        self.networkProvider = networkProvider
    }
    
    //MARK: - methods
    func searchGitHub(_ query: String) -> BehaviorSubject<[RepoViewData]>{
        // call the Api and get the data
        print("Hello Search binding")
        guard let networkProvider = networkProvider else {
            return reposData
        }
        let data = networkProvider.getRepos(query: query)
//        let data = [
//            RepoViewData(ownerName: "dsa", ownerAvatarURL: "", repoName: "dsadad", repoDescription: "csacasc", starsCount: 3000, repoProgrammingLanguage: "python")
//        ]
        reposData.onNext(data)
        //reposData.onCompleted()
        return reposData
    }
    
}
