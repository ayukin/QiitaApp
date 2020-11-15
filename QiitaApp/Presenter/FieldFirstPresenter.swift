//
//  FieldFirstPresenter.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/07.
//

import Foundation

protocol FieldFirstPresenterInput {
    var articles: [ArticleEntity] { get }
    func getArticlesAction()
    func refreshArticlesAction()
    func updateArticlesAction()
    func article(forRow row: Int) -> ArticleEntity?
    func transitionAction(forRow row: Int)
}

protocol FieldFirstPresenterOutput: AnyObject {
    func completedGetArticlesAction(_ articles: [ArticleEntity])
    func failedGetArticlesAction()
}

final class FieldFirstPresenter: FieldFirstPresenterInput {
    
    private weak var view: FieldFirstPresenterOutput!
    private var model: FieldFirstModelInput
    private var router: FieldFirstTransitionRouter
    
    private(set) var articles: [ArticleEntity] = []
    
    private var reloading: Bool = false
    private var page: Int = 20
    
    init(view: FieldFirstPresenterOutput, model: FieldFirstModelInput, router: FieldFirstTransitionRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    // Qiitaからデータ取得する処理
    func getArticlesAction() {
        model.getAPIInformations(page: page) { [self] (articles) in
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
