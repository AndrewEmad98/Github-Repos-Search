//
//  RepoTableViewCell.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 09/11/2022.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var programmingLanguage: UILabel!
    @IBOutlet weak var starsNumberLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellSetup(repo: RepoViewData){
        programmingLanguage.text = repo.repoProgrammingLanguage
        starsNumberLabel.text = repo.starsCount
        repoDescriptionLabel.text = repo.repoDescription
        repoNameLabel.text = repo.repoName
        // add KingFisher Here to fetch the two images
    }
}
