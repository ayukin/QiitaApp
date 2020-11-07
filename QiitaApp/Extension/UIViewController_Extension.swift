//
//  UIViewController_Extension.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/10/31.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {
    // アクティビティインディケータのアニメーションを開始するメソッド
    func startIndicator(style: String) {
        
        if style == "lineSpinFadeLoader" {
            let posX: CGFloat = self.view.bounds.width/2 - 15
            let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: posX, y: 150, width: 30, height: 30), type: NVActivityIndicatorType.lineSpinFadeLoader, color: UIColor.lightGray, padding: 0)
            activityIndicatorView.startAnimating()
            
            let loadingView = UIView(frame: self.view.bounds)
            loadingView.backgroundColor = UIColor.white

            // 他のViewと被らない値を代入
            loadingView.addSubview(activityIndicatorView)
            self.view.addSubview(loadingView)
             // overlayView.tag = 999

        } else if style == "circleStrokeSpin" {
            let posX: CGFloat = self.view.bounds.width/2 - 30
            let posY: CGFloat = self.view.bounds.height/2 - 30
            let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: posX, y: posY, width: 60, height: 60), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.lightGray, padding: 0)
            activityIndicatorView.startAnimating()

            let loadingView = UIView(frame: self.view.bounds)
            loadingView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)

            // 他のViewと被らない値を代入
            loadingView.addSubview(activityIndicatorView)
            self.view.addSubview(loadingView)
             // overlayView.tag = 999
        }
        
    }
    
    // エンプティービューを表示させるメソッド
    func displayEmptyView(message: String) {
        let width: CGFloat = self.view.bounds.width - 40
        let label: UILabel = UILabel(frame: CGRect(x: 20, y: 150, width: width, height: 21))
        
        label.text = message
        label.textColor = UIColor.systemGray2
        label.textAlignment = .center
        
        let emptyView = UIView(frame: self.view.bounds)
        emptyView.backgroundColor = UIColor.systemGroupedBackground

        // 他のViewと被らない値を代入
        emptyView.addSubview(label)
        self.view.addSubview(emptyView)
         // overlayView.tag = 999
    }

    // アクティビティインディケータのアニメーションを停止させるメソッド
    func dismissIndicator() {
        self.view.subviews.last?.removeFromSuperview()
        // self.view.viewWithTag(999)?.removeFromSuperview()
    }
    
}
