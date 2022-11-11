//
//  NetworkingProvider.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 10/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol NetworkingProviderProtocol {
    func getRepos(query: String) -> [RepoViewData]
}
