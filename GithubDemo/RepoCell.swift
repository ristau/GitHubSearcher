//
//  RepoCell.swift
//  GithubDemo
//
//  Created by Barbara Ristau on 2/1/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit
import AFNetworking

class RepoCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var forksCount: UILabel!
  @IBOutlet weak var starsCount: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var ownerLabel: UILabel!
  @IBOutlet weak var avatarImage: UIImageView!
  
  var repo: GithubRepo! {
    didSet{
     
      nameLabel.text = repo.name
      ownerLabel.text = ("By \(repo.ownerHandle!)")
      starsCount.text = String(describing: repo.stars!)
      forksCount.text = String(describing: repo.forks!)
      descriptionLabel.text = repo.repoDescription!
      avatarImage.setImageWith(URL(string: repo.ownerAvatarURL!)!)

    }
  }
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
