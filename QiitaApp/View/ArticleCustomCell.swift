//
//  ArticleCustomCell.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/10/28.
//

import UIKit
import Foundation
import Nuke

class ArticleCustomCell: UITableViewCell {
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var article: ArticleEntity? {
        didSet {
            if let url = URL(string: article?.user.profile_image_url ?? "") {
                Nuke.loadImage(with: url, into: profileImageView)
            }
            titleLabel.text = article?.title
            let formatter = ISO8601DateFormatter()
            if let date = formatter.date(from: article?.created_at ?? "") {
                let createdAt = Date().formatterDateStyleMedium(date: date)
                nameLabel.text = "by \(article?.user.id ?? "") \(createdAt)"
            } else {
                nameLabel.text = "by \(article?.user.id ?? "") \(article?.created_at ?? "")"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 25
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 0
        nameLabel.textColor = UIColor.lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
