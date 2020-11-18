//
//  FieldThirdPresenter.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/05.
//

import Foundation
import Alamofire

protocol FieldThirdPresenterInput {
    var articles: [ArticleEntity] { get }
    func getArticlesAction()
    func refreshArticlesAction()
    func updateArticlesAction()
    func article(forRow row: Int) -> ArticleEntity?
    func transitionAction(forRow row: Int)
}

protocol FieldThirdPresenterOutput: AnyObject {
    func completedGetArticlesAction(_ articles: [ArticleEntity])
    func failedGetArticlesAction(string: String)
}

final class FieldThirdPresenter: FieldThirdPresenterInput {
    
    private weak var view: FieldThirdPresenterOutput!
    private var model: FieldThirdModelInput
    private var router: FieldThirdTransitionRouter
    
    private(set) var articles: [ArticleEntity] = []
    
    private var reloading: Bool = false
    private var page: Int = 20
    
    init(view: FieldThirdPresenterOutput, model: FieldThirdModelInput, router: FieldThirdTransitionRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    // Qiitaからデータ取得する処理
    func getArticlesAction() {
        model.getAPIInformations(page: page) { [self] (response) in
            switch response {
            case .success(let repositories):
                // 情報が取得できているか判定
                if let articleValue = repositories {
                    // リロード処理のフラグ変更を「false」
                    if reloading { reloading.toggle() }

                    if articleValue.count == 0 {
                        // 検索結果が０件の場合
                        view.failedGetArticlesAction(string: "検索結果が０件です")
                    } else {
                        // 取得成功の場合
                        self.articles = articleValue
                        view.completedGetArticlesAction(self.articles)
                    }
                } else {
                    // 取得失敗の場合
                    view.failedGetArticlesAction(string: "テータ取得に失敗しました")
                }
            case .failure(let e):
                if case AFError.sessionTaskFailed(error: let error) = e {
                    let nsError = error as NSError
                    // ネットワーク接続エラー（ NSURLErrorNotConnectedToInternet = -1009 ）
                    if nsError.code == -1009 {
                        print(nsError.domain)
                        print(nsError.code)
                        print(nsError.userInfo)
                        // 取得失敗の場合
                        view.failedGetArticlesAction(string: "ネットワークに接続されていません")
                    } else {
                        print(nsError.domain)
                        print(nsError.code)
                        print(nsError.userInfo)
                    }
                } else {
                    print(e.localizedDescription)
                    // 取得失敗の場合
                    view.failedGetArticlesAction(string: "通信エラーが発生しました")
                }
            }
        }
    }

    
    func refreshArticlesAction() {
        // 取得数を初期値にする
        page = 20
        // Qiitaからデータ取得する処理
        getArticlesAction()
    }
    
    func updateArticlesAction() {
        if !reloading && page < 100 {
            // 取得数を20追加にする
            if page <= 100 { page += 20 }
            // リロード処理のフラグ変更を「true」
            reloading.toggle()
            // Qiitaからデータ取得する処理
            getArticlesAction()
        }
    }
    
    func article(forRow row: Int) -> ArticleEntity? {
        guard row < articles.count else { return nil }
        return articles[row]
    }
    
    func transitionAction(forRow row: Int) {
        guard row < articles.count else { return }
        let url = articles[row].url
        // 画面遷移の処理
        router.transition(url: url)
    }
        
}
