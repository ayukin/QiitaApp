//
//  FieldThirdViewController.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/10/27.
//

import UIKit
import XLPagerTabStrip

final class FieldThirdViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: FieldThirdPresenterInput!
    func inject(presenter: FieldThirdPresenterInput) {
        self.presenter = presenter
    }
    
    var refreshControl: UIRefreshControl!
    private let CELL_IDENTIFIER = "cell"
    
    //ここがボタンのタイトルに利用されます
    var itemInfo: IndicatorInfo = "Swift"

    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面UIについての処理
        setupUI()
        // アクティビティインディケータのアニメーションを開始
        startIndicator(style: "lineSpinFadeLoader")
        // Qiitaからデータ取得する処理
        presenter.getArticlesAction()
    }
    
    func setupUI() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "再読み込み中")
        refreshControl.addTarget(self, action: #selector(self.refreshArticlesAction), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        tableView.register(UINib(nibName: "ArticleCustomCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER)
    }
    
    @objc func refreshArticlesAction() {
        // Qiitaからデータ取得する処理
        presenter.refreshArticlesAction()
    }
    
}

extension FieldThirdViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

extension FieldThirdViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as? ArticleCustomCell else {
            return UITableViewCell()
        }
        if let article = presenter.article(forRow: indexPath.row) {
            cell.article = article
        }
        return cell
    }
    
}

extension FieldThirdViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 遷移先のView（WebViewController）を取得
        let storyboard = UIStoryboard(name: "Web", bundle: nil)
        let webVC = storyboard.instantiateViewController(withIdentifier: "WebVC") as! WebViewController
        // WebViewControllerへ情報を渡す
        if let article = presenter.article(forRow: indexPath.row) {
            webVC.url = article.url
        }
        // WebViewControllerの「戻るボタン」をカスタマイズ
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        // WebViewControllerへ画面遷移
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            // Qiitaからデータ取得する処理
            presenter.updateArticlesAction()
        }
    }

}

extension FieldThirdViewController: FieldThirdPresenterOutput {
    // Qiitaからデータの取得完了した時の処理
    func completedGetArticlesAction(_ articles: [ArticleEntity]) {
        if self.view.subviews.count >= 2 {
            dismissIndicator()
        }
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    // Qiitaからデータの取得失敗した時の処理
    func failedGetArticlesAction() {
        if self.view.subviews.count >= 2 {
            dismissIndicator()
        }
        refreshControl.endRefreshing()
        displayEmptyView(message: "データ取得に失敗しました")
    }
    
}

