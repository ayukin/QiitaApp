//
//  SearchModel.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/12/01.
//

import Foundation

protocol SearchModelInput {
    func getSearchList() -> [String]
    func removeSearchList(indexPath: Int)
    func appendSearchList(text: String)
}

final class SearchModel: SearchModelInput {
    // UserDefaultsから検索履歴を読み込む
    func getSearchList() -> [String] {
        let userDefaults = UserDefaults.standard
        if let storedSearchList = userDefaults.array(forKey: "searchList") as? [String] {
            return storedSearchList
        }
        return []
    }
    // UserDefaultsから削除
    func removeSearchList(indexPath: Int) {
        let userDefaults = UserDefaults.standard
        var storedSearchList = userDefaults.array(forKey: "searchList") as? [String]
        storedSearchList?.remove(at: indexPath)
        userDefaults.set(storedSearchList, forKey: "searchList")
    }
    // UserDefaultsに保存
    func appendSearchList(text: String) {
        let userDefaults = UserDefaults.standard
        var storedSearchList = userDefaults.array(forKey: "searchList") as? [String] ?? []
        storedSearchList.append(text)
        userDefaults.set(storedSearchList, forKey: "searchList")
    }
}
