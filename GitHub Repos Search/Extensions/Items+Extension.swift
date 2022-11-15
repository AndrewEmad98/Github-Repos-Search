//
//  Items+Extension.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 15/11/2022.
//

import Foundation

extension Item:RepoViewDataProtocol {
    var ownerName: String {
        var owner = self.fullName
        if let i = owner.firstIndex(of: "/") {
            owner.remove(at: i) // i is character index
        }
        return owner
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
