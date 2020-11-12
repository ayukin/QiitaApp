//
//  CustomTableView.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/10.
//

import UIKit

class CustomTableView: UITableView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame:CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        setup()
    }
    
    private func setup() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "読み込み中")
        self.refreshControl = refreshControl
    }
        
    func addTargetToRefreshControl(_ target: Any?, action: Selector, event: UIControl.Event) {
        self.refreshControl?.addTarget(target, action: action, for: event)
    }

    func beginRefreshing() {
        guard let refreshControl = self.refreshControl else { return }
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
        self.contentOffset.y = -self.bounds.height
    }
    
    func endRefreshing() {
        guard let refreshControl = self.refreshControl else { return }
        refreshControl.endRefreshing()
    }
    
}
