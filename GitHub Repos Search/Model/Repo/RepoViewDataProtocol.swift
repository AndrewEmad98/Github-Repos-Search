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


extension Item:RepoViewDataProtocol {
    var ownerName: String {
        self.fullName
    }
    
    var ownerAvatarURL: String {
        self.owner.avatarURL
    }
    
    var repoName: String {
        self.name
    }
    
    var repoDescription: String? {
        self.itemDescription
    }
    
    var starsCount: Int {
        self.stargazersCount
    }
    
    var repoProgrammingLanguage: String {
        self.language ?? ""
    }
}
