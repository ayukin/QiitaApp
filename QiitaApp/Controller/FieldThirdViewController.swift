//
//  FieldThirdViewController.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/10/27.
//

import UIKit
import XLPagerTabStrip

final class FieldThirdViewController: UIViewController {
    
    @IBOutlet private weak var tableView: CustomTableView!
    
    private var presenter: FieldThirdPresenterInput!
    func inject(presenter: FieldThirdPresenterInput) {
        self.presenter = presenter
    }
    
    private let CELL_IDENTIFIER = "cell"
    
    //ここがボタンのタイトルに利用されます
    private var itemInfo: IndicatorInfo = "Swift"

    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面UIについての処理
        setupUI()
        // アクティビティインディケータのアニメーションを開始
        startIndicator(style: "lineSpinFadeLoader")
        // Qiitaからデータ取得する処理
        presenter.getArticlesAction()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: "ArticleCustomCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER)
        tableView.addTargetToRefreshControl(self, action: #selector(self.refreshArticlesAction))
    }
    
    @objc private func refreshArticlesAction() {
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
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    // Qiitaからデータの取得失敗した時の処理
    func failedGetArticlesAction() {
        if self.view.subviews.count >= 2 {
            dismissIndicator()
        }
        tableView.refreshControl?.endRefreshing()
        displayEmptyView(message: "データ取得に失敗しました")
    }
    
}

