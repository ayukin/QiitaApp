//
//  SearchTransition.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/14.
//

import UIKit

protocol SearchTransitionRouter {
    func transition(tag: String)
}

class SearchTransition: SearchTransitionRouter {
    
    // 画面遷移のためにViewControllerが必要。initで受け取る
    private unowned let viewController: SearchViewController
    
    init(viewController: SearchViewController) {
        self.viewController = viewController
    }
    
    func transition(tag: String) {
        // 遷移先のView（WebViewController）を取得
        guard let searchArticleVC = UIStoryboard(name: "SearchArticle", bundle: nil).instantiateViewController(withIdentifier: "SearchArticleVC") as? SearchArticleViewController else { return }
        searchArticleVC.tag = tag
        // WebViewControllerの「戻るボタン」をカスタマイズ
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backBarButton
        // WebViewControllerへ画面遷移
        viewController.navigationController?.pushViewController(searchArticleVC, animated: true)
    }
    
}

