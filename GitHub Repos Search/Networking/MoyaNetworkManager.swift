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
    private var disposeBag = DisposeBag()
    
    static let shared = MoyaNetworkManager()
    private init(){}
    
    func getRepos(query: String,page: Int = 1)-> Observable<[RepoViewData]> {
        MoyaProviderServices.pageNumber = page
        return getNativeRepos(query: query).map { [weak self] nativeData -> [RepoViewData]  in
            guard let self = self else {return []}
            print(nativeData)
            return self.parseData(data: nativeData)
        }.asObservable()
    }

    
    private func getNativeRepos(query: String) -> Observable<ReposData> {
        provider.rx.request(.getRepos(query: query)).subscribe { event in
            switch event{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                break
            }
        }.disposed(by: disposeBag)
        return provider.rx.request(.getRepos(query: query))
            .map(ReposData.self)
            .asObservable()
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
