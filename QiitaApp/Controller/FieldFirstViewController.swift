//
//  FieldFirstViewController.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/10/27.
//

import UIKit
import XLPagerTabStrip

final class FieldFirstViewController: UIViewController {
    
    @IBOutlet private weak var tableView: CustomTableView! {
        didSet {
            tableView.register(UINib(nibName: "ArticleCustomCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER)
            tableView.addTargetToRefreshControl(self, action: #selector(self.refreshArticlesAction), event: .valueChanged)
        }
    }
    
    private var presenter: FieldFirstPresenterInput!
    func inject(presenter: FieldFirstPresenterInput) {
        self.presenter = presenter
    }
    
    private let CELL_IDENTIFIER = "cell"
    
    //ここがボタンのタイトルに利用されます
    private var itemInfo: IndicatorInfo = "新着"

    override func viewDidLoad() {
        super.viewDidLoad()
        // refreshControlを呼び出し、ローディングする
        tableView.beginRefreshing()
        // Qiitaからデータ取得する処理
        presenter.getArticlesAction()

    }
        
    @objc private func refreshArticlesAction() {
        // Qiitaからデータ取得する処理
        presenter.refreshArticlesAction()
    }
    
}

extension FieldFirstViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

extension FieldFirstViewController: UITableViewDataSource {
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

extension FieldFirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        // WebViewControllerへ画面遷移する処理
        presenter.transitionAction(forRow: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y > 0 else { return }
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            // Qiitaからデータ取得する処理
            presenter.updateArticlesAction()
        }
    }

}

extension FieldFirstViewController: FieldFirstPresenterOutput {
    // Qiitaからデータの取得完了した時の処理
    func completedGetArticlesAction(_ articles: [ArticleEntity]) {
        tableView.endRefreshing()
        tableView.reloadData()
    }
    // Qiitaからデータの取得失敗した時の処理
    func failedGetArticlesAction(string: String) {
        tableView.endRefreshing()
        displayEmptyView(message: string)
    }
}
