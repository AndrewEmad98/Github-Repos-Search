//
//  RepoTableViewCell.swift
//  GitHub Repos Search
//
//  Created by Andrew Emad on 09/11/2022.
//

import UIKit
import Kingfisher

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
    
    func cellSetup(repo: RepoViewDataProtocol){
        programmingLanguage.text = repo.repoProgrammingLanguage
        var owner = repo.ownerName
        //TODO:- remove logic from any view
        if let i = owner.firstIndex(of: "/") {
            owner.remove(at: i) // i is character index
        }
        ownerNameLabel.text = owner
        starsNumberLabel.text = "\(repo.starsCount)"
        repoDescriptionLabel.text = repo.repoDescription
        repoNameLabel.text = repo.repoName
        ownerAvatarImageView.setImage(with: repo.ownerAvatarURL.toURl)
    }
}
