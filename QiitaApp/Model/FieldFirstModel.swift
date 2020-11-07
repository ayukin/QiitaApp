//
//  FieldFirstModel.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/01.
//

import Foundation
import Alamofire

protocol FieldFirstModelInput {
    func getAPIInformations(page: Int, callback: @escaping ([ArticleEntity]?) -> Void)
}

final class FieldFirstModel: FieldFirstModelInput {
    
    func getAPIInformations(page: Int, callback: @escaping ([ArticleEntity]?) -> Void) {
        let url = "https://qiita.com/api/v2/items?page=1&per_page=\(page)"
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
