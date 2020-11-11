//
//  SearchViewController.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/10/26.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var presenter: SearchPresenterInput!
    func inject(presenter: SearchPresenterInput) {
        self.presenter = presenter
    }

    private var searchBar: UISearchBar!
    var selectedCellIndex: IndexPath?

    private let CELL_IDENTIFIER = "searchCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchPresenter(view: self)
        // UserDefaultsから検索履歴を読み込む
        presenter.getSearchListAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 画面UIについての処理
        setupSearchBar()
        tableView.reloadData()
    }

    private func setupSearchBar() {
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.placeholder = "キーワードを入力"
            searchBar.tintColor = UIColor.gray
            searchBar.searchTextField.backgroundColor = UIColor.white
            searchBar.keyboardType = UIKeyboardType.default
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
            self.searchBar = searchBar
        }
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        if let searchWord = presenter.search(forRow: indexPath.row) {
            cell.searchLabel.text = searchWord
        }
        cell.cellDone = { [weak self] in
            self?.selectedCellIndex = indexPath
        }
        cell.delegate = self
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func refreshArticlesAction() {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 遷移先のView（SearchArticleViewController）を取得
        let storyboard = UIStoryboard(name: "SearchArticle", bundle: nil)
        let searchArticleVC = storyboard.instantiateViewController(withIdentifier: "SearchArticleVC") as! SearchArticleViewController
        // SearchArticleViewControllerへ情報を渡す
        if let searchWord = presenter.search(forRow: indexPath.row) {
            searchArticleVC.tag = searchWord
        }
        // SearchArticleViewControllerの「戻るボタン」をカスタマイズ
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        // SearchArticleViewControllerへ画面遷移
        self.navigationController?.pushViewController(searchArticleVC, animated: true)
    }
}

extension SearchViewController: SearchTableViewCellDelegate {
    func deleteCellAction() {
        // todolistとUserDefaultsから削除
        presenter.removeSearchListAction(indexPath: selectedCellIndex!.row as Int)
    }
}

extension SearchViewController: UISearchBarDelegate {
    // 編集が開始されたら、キャンセルボタンを有効にする
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    // 検索キータップ時に呼び出されるメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        
        guard let text = searchBar.text else { return }
        // todolistとUserDefaultsへ検索履歴の保存
        presenter.appendSearchListAction(text: text)
        
        // 遷移先のView（SearchArticleViewController）を取得
        let storyboard = UIStoryboard(name: "SearchArticle", bundle: nil)
        let searchArticleVC = storyboard.instantiateViewController(withIdentifier: "SearchArticleVC") as! SearchArticleViewController
        // SearchArticleViewControllerへ情報を渡す
        searchArticleVC.tag = text
        // SearchArticleViewControllerの「戻るボタン」をカスタマイズ
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        // SearchArticleViewControllerへ画面遷移
        self.navigationController?.pushViewController(searchArticleVC, animated: true)
    }
    
    // キャンセルボタンが押されたらキャンセルボタンを無効にしてフォーカスを外す
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }

}

extension  SearchViewController: SearchPresenterOutput {
    func reloadAction() {
        tableView.reloadData()
    }
}
