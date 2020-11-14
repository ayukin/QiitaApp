//
//  SearchArticleTransition.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/14.
//

import UIKit

protocol SearchArticleTransitionRouter {
    func transition(url: String)
}

class SearchArticleTransition: SearchArticleTransitionRouter {
    
    // 画面遷移のためにViewControllerが必要。initで受け取る
    private unowned let viewController: SearchArticleViewController
    
    init(viewController: SearchArticleViewController) {
        self.viewController = viewController
    }
    
    func transition(url: String) {
        // 遷移先のView（WebViewController）を取得
        guard let webVC = UIStoryboard(name: "Web", bundle: nil).instantiateViewController(withIdentifier: "WebVC") as? WebViewController else { return }
        webVC.url = url
        // WebViewControllerの「戻るボタン」をカスタマイズ
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backBarButton
        // WebViewControllerへ画面遷移
        viewController.navigationController?.pushViewController(webVC, animated: true)
    }
    
}

