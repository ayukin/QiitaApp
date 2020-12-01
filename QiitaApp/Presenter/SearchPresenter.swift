//
//  SearchPresenter.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/07.
//

import Foundation

protocol SearchPresenterInput {
    var searchList: [String] { get }
    func getSearchListAction()
    func removeSearchListAction(indexPath: Int)
    func appendSearchListAction(text: String)
    func search(forRow row: Int) -> String?
    func transitionAction(forRow row: Int)
}

protocol SearchPresenterOutput: AnyObject {
    func reloadAction()
}

final class SearchPresenter: SearchPresenterInput {
    
    private weak var view: SearchPresenterOutput!
    private var model: SearchModelInput
    private var router: SearchTransitionRouter
    private(set) var searchList: [String] = []
        
    init(view: SearchPresenterOutput, model: SearchModelInput, router: SearchTransitionRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    func getSearchListAction() {
        // UserDefaultsから検索履歴を読み込む
        searchList = model.getSearchList()
    }
    
    func removeSearchListAction(indexPath: Int) {
        // todolistから削除
        searchList.remove(at: indexPath)
        // UserDefaultsから削除
        model.removeSearchList(indexPath: indexPath)
        // tableViewの更新
        view.reloadAction()
    }
    
    func appendSearchListAction(text: String) {
        // 保存済み検索履歴の二重チェック
        if !searchList.contains(text) {
            // todolistに保存
            searchList.append(text)
            // UserDefaultsに保存
            model.appendSearchList(text: text)
        }
        // 画面遷移の処理
        router.transition(tag: text)
    }
    
    func search(forRow row: Int) -> String? {
        guard row < searchList.count else { return nil }
        return searchList[row]
    }
    
    func transitionAction(forRow row: Int) {
        guard row < searchList.count else { return }
        let text = searchList[row]
        // 画面遷移の処理
        router.transition(tag: text)
    }
    
}
