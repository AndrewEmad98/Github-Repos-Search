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
    
    func getRepos(query: String)-> PublishRelay<[RepoViewData]> {
        let data = getData(query: query)
        print(data)
        return filterData(data: data)
    }
    
    private func getData(query: String) -> Single<[ReposData]>{
        provider.request(.getRepos(query: query)) { result in
            switch result {
            case .success(let data):
                // parse JSON
                let arr = try? data.map(ReposData.self)
                if let arr = arr {
                    print("json decoded")
                    print(arr)
                }else{
                    print("can't decode json")
                }
                // filter Data
                
            case .failure(let error):
                print(error.errorDescription ?? "")
            }
        }
        return provider.rx.request(.getRepos(query: query))
            .filterSuccessfulStatusAndRedirectCodes()
            .map([ReposData].self)
    }
    private func filterData(data: Single<[ReposData]>)-> PublishRelay<[RepoViewData]>{

//        let value = try? await data.value
        
        let publishRelay = PublishRelay<[RepoViewData]>()
        return publishRelay
        
        
//        data.map { realData in
//            var array: [RepoViewData] = []
//            for repo in realData {
//                let object: RepoViewData = RepoViewData()
//                object.ownerAvatarURL = repo
//            }
//        }
    }
    
}
