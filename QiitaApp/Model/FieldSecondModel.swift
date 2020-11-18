//
//  FieldSecondModel.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/04.
//

import Foundation
import Alamofire

protocol FieldSecondModelInput {
    func getAPIInformations(page: Int, completion: @escaping (Result<[ArticleEntity]?, Error>) -> Void)
}

final class FieldSecondModel: FieldSecondModelInput {
    
    func getAPIInformations(page: Int, completion: @escaping (Result<[ArticleEntity]?, Error>) -> Void) {
        
        let url = UrlStyle.ios.urlType(page: page)
        
        AF.request(url).validate().response { response in
            switch response.result {
            case .success(let response):
                guard let data = response else { return }
                do {
                    let repositories = try JSONDecoder().decode([ArticleEntity].self, from: data)
                    completion(.success(repositories))
                } catch {
                    completion(.success(nil))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
        
}
