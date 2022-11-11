//
//  MoyaNetworkManager.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 10/11/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class MoyaNetworkManager: NetworkingProviderProtocol {
    
    private let provider = MoyaProvider<MoyaProviderServices>()
    
    static let shared = MoyaNetworkManager()
    private init(){}
    var responseData = PublishRelay<ReposData>()
    private var disposeBag = DisposeBag()
    
    func getRepos(query: String)-> [RepoViewData] {
//        var repoViewData: [RepoViewData] = []
//        let data = getData(query: query)
//        if let data = data {
//            repoViewData = parseData(data: data)
//        }else{
//            // error
//        }

//        provider.request(.getRepos(query: query)) { result in
//            switch result {
//            case .success(let response):
//                let arr = try? response.map(ReposData.self)
//            case .failure(let error):
//            }
//        }
        
        let data: ReposData = ReposData(totalCount: 1, incompleteResults: true, items: [])
        return parseData(data: data)
        
//        return provider.rx.request(.getRepos(query: query))
//            .filterSuccessfulStatusAndRedirectCodes()
//            .map(ReposData.self)
    }
    
    private func getData(query: String) -> ReposData?{
//        provider.request(.getRepos(query: query)) { result in
//            switch result {
//            case .success(let data):
//                let arr = try? data.map(ReposData.self)
//                if let arr = arr {
//                    // decoded data is here
//                }else{
//                    print("can't decode json")
//                }
//            case .failure(let error):
//                print(error.errorDescription ?? "")
//            }
//        }
        return nil
    }
    
//    private func filterData(data: Single<[ReposData]>)-> PublishRelay<[RepoViewData]>{
//    }
    
    private func parseData(data: ReposData)-> [RepoViewData]{
        var repoViewData: [RepoViewData] = []
        for item in data.items {
            let repoData: RepoViewData = RepoViewData(ownerName: item.fullName, ownerAvatarURL: item.owner.avatarURL, repoName: item.name, repoDescription: item.itemDescription, starsCount: item.stargazersCount, repoProgrammingLanguage: item.language ?? "")
            repoViewData.append(repoData)
        }
        return repoViewData
    }
}
