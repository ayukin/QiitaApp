//
//  ApiError.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/19.
//

import Foundation
import Alamofire

struct ApiError {
    let error: Error
    var errorMessage: String {
        switch error {
        case AFError.sessionTaskFailed(error: let e):
            switch (e as NSError).code {
            case NSURLErrorNotConnectedToInternet:
                return "ネットワークに接続されていません"
            case NSURLErrorTimedOut:
                return "接続がタイムアウトになりました"
            default:
                return "通信エラーが発生しました"
            }
        default:
            return "通信エラーが発生しました"
        }
    }
}
