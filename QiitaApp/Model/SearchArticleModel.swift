//
//  SearchArticleModel.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/05.
//

import Foundation
import Alamofire

protocol SearchArticleModelInput {
    func getAPIInformations(page: Int, tag: String, callback: @escaping ([ArticleEntity]?) -> Void)
}

final class SearchArticleModel: SearchArticleModelInput {
    
    func getAPIInformations(page: Int, tag: String, callback: @escaping ([ArticleEntity]?) -> Void) {
        
        let url = UrlStyle.search(tag: tag).urlType(page: page)
        
        AF.request(url).validate().response { response in
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                do {
                    let articles = try JSONDecoder().decode([ArticleEntity].self, from: data)
                    callback(articles)
                } catch {
                    callback(nil)
                }
            case .failure(_):
                print(response.error ?? "")
                callback(nil)
            }
        }
    }
        
}

