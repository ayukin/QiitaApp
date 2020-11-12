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
            return url + "&query=tag:\(tag)"
        }
    }
        
}

        


