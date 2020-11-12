//
//  WebViewController.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/01.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        if let url = URL(string: url ?? "https://qiita.com/") {
            self.webView.load(URLRequest(url: url))
        }
    }

}

extension WebViewController: WKNavigationDelegate {
    // webViewが読み込みを開始した時に実行されるメソッド
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        startIndicator(style: "circleStrokeSpin")
    }
    // webViewが読み込みを終了した時に実行されるメソッド
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        dismissIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        dismissIndicator()
        displayEmptyView(message: "データ取得に失敗しました")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        dismissIndicator()
    }

}
