//
//  UrlStyle.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/11.
//

import Foundation

struct UrlTrade {
    enum Trade {
        case new(page: Int)
        case ios(page: Int)
        case swift(page: Int)
        case search(page: Int, tag: String)
    }

    func urlType(type: Trade) -> String {
        let urlString = "https://qiita.com/api/v2/items?page=1&per_page="
        switch type {
        case let Trade.new(page):
            let pageString = "&per_page=\(page)"
            let url = urlString + pageString
            return url
        case let Trade.ios(page):
            let pageString = "&per_page=\(page)"
            let url = urlString + pageString + "&query=tag:iOS"
            return url
        case let Trade.swift(page):
            let pageString = "&per_page=\(page)"
            let url = urlString + pageString + "&query=tag:Swift"
            return url
        case let Trade.search(page, tag):
            let pageString = "&per_page=\(page)"
            let url = urlString + pageString + "&query=tag:\(tag)"
            return url
        }
    }
}

//let UrlType = UrlTrade.Trade.ios(page: 20)
//let url = UrlTrade.urlType(type: UrlType)

