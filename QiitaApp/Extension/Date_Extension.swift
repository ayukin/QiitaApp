//
//  Date_Extension.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/02.
//

import Foundation

extension Date {
    // 出力フォーマット「0000/00/00 00:00」
    func formatterDateStyleMedium(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }
}
