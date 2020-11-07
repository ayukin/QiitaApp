//
//  ArticleEntity.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/10/29.
//

import Foundation

struct ArticleEntity: Codable {

    var title: String
    var created_at: String
    var url: String
    var user: User

    struct User: Codable {
        var id: String
        var profile_image_url: String
    }
    
}
