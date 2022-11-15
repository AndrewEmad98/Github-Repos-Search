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
    
    private var provider = MoyaProvider<MoyaProviderServices>()
    static let shared = MoyaNetworkManager()
    private init(){}
    
    func getRepos(query: String,page: Int = 1)-> Observable<[RepoViewDataProtocol]> {
        MoyaProviderServices.pageNumber = page
        return getNativeRepos(query: query).map { nativeData -> [RepoViewDataProtocol]  in
            return nativeData.items
        }.asObservable()
    }

    private func getNativeRepos(query: String) -> Observable<ReposData> {
        return provider.rx.request(.getRepos(query: query))
            .map(ReposData.self)
            .asObservable()
    }
    
}
