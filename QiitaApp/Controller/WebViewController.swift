//
//  WebViewController.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/01.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
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
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        startIndicator(style: "circleStrokeSpin")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("読み込み完了")
        dismissIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("読み込み失敗")
        dismissIndicator()
        displayEmptyView(message: "データ取得に失敗しました")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        dismissIndicator()
    }

    
    
}
