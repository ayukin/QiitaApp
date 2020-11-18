//
//  UrlStyle.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/11.
//

import Foundation
    
enum UrlStyle {
    case new
    case ios
    case swift
    case search(tag: String)
    
    func urlType(page: Int) -> String {
        let url = "https://qiita.com/api/v2/items?page=1&per_page=\(page)"
        switch self {
        case .new:
            return url
        case .ios:
            return url + "&query=tag:iOS"
        case .swift:
            return url + "&query=tag:Swift"
        case let .search(tag):
            // 検索文字列にパーセントエンコーディングをかける
            if let tagString: String = tag.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                return url + "&query=tag:\(tagString)"
            }
            return url + "&query=tag:\(tag)"
        }
    }
        
}

        


