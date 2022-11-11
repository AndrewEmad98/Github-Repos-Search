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
    private var disposeBag = DisposeBag()
    
    func getRepos(query: String)-> Observable<[RepoViewData]> {
        return getNativeRepos(query: query).map { [weak self] nativeData -> [RepoViewData]  in
            guard let self = self else {return []}
            print(nativeData)
            return self.parseData(data: nativeData)
        }.asObservable()
    }
    
    private func getNativeRepos(query: String)-> Observable<ReposData> {
        return provider.rx.request(.getRepos(query: query)).map(ReposData.self).asObservable()
    }

    private func parseData(data: ReposData)-> [RepoViewData]{
        var repoViewData: [RepoViewData] = []
        for item in data.items {
            let repoData: RepoViewData = RepoViewData(ownerName: item.fullName, ownerAvatarURL: item.owner.avatarURL, repoName: item.name, repoDescription: item.itemDescription, starsCount: item.stargazersCount, repoProgrammingLanguage: item.language ?? "")
            repoViewData.append(repoData)
        }
        return repoViewData
    }
}
