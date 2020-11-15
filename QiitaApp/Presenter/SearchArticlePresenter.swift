//
//  SearchArticlePresenter.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/07.
//

import Foundation

protocol SearchArticlePresenterInput {
    var articles: [ArticleEntity] { get }
    func getArticlesAction(tag: String)
    func refreshArticlesAction(tag: String)
    func updateArticlesAction(tag: String)
    func article(forRow row: Int) -> ArticleEntity?
    func transitionAction(forRow row: Int)
}

protocol SearchArticlePresenterOutput: AnyObject {
    func completedGetArticlesAction(_ articles: [ArticleEntity])
    func failedGetArticlesAction()
}

final class SearchArticlePresenter: SearchArticlePresenterInput {
    
    private weak var view: SearchArticlePresenterOutput!
    private var model: SearchArticleModelInput
    private var router: SearchArticleTransitionRouter
    
    private(set) var articles: [ArticleEntity] = []
    
    private var reloading: Bool = false
    private var page: Int = 20
    
    init(view: SearchArticlePresenterOutput, model: SearchArticleModelInput, router: SearchArticleTransitionRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    // Qiitaからデータ取得する処理
    func getArticlesAction(tag: String) {
        model.getAPIInformations(page: page, tag: tag) { [self] (articles) in
            // 情報が取得できているか判定
            if let articleValue = articles {
                // 取得成功の場合
                if reloading {
                    // リロード処理のフラグ変更を「false」
                    reloading.toggle()
                }
                // 取得成功の場合
                self.articles = articleValue
                view.completedGetArticlesAction(self.articles)
            } else {
                // 取得失敗の場合
                view.failedGetArticlesAction()
            }
        }
    }
    
    func refreshArticlesAction(tag: String) {
        // 取得数を初期値にする
        page = 20
        // Qiitaからデータ取得する処理
        getArticlesAction(tag: tag)
    }
    
    func updateArticlesAction(tag: String) {
        if !reloading && page < 100 {
            // 取得数を20追加にする
            if page <= 100 { page += 20 }
            // リロード処理のフラグ変更を「true」
            reloading.toggle()
            // Qiitaからデータ取得する処理
            getArticlesAction(tag: tag)
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
