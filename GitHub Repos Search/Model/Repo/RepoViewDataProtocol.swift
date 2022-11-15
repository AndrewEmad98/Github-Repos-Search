//
//  RepoViewData.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 09/11/2022.
//

import Foundation

protocol RepoViewDataProtocol{
    var ownerName : String { get }
    var ownerAvatarURL : String {get}
    var repoName: String {get}
    var repoDescription: String? {get}
    var starsCount: Int {get}
    var repoProgrammingLanguage: String {get}
}

