//
//  FieldViewController.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/10/26.
//

import UIKit
import XLPagerTabStrip

class FieldViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        // 画面UIについての処理
        setupUI()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 強制的に再選択し、changeCurrentIndexProgressiveを動作させる（ 0番目 → 1番目 → 0番目 ）
        moveToViewController(at: 1, animated: false)
        moveToViewController(at: 0, animated: false)
    }
    
    func setupUI() {
        self.navigationItem.title = "Qiita"
        // ButtonBar全体の背景色
        settings.style.buttonBarBackgroundColor = UIColor.white
        // ButtonBarItemの背景色
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        // ButtonBarItemの文字色
        settings.style.buttonBarItemTitleColor = UIColor.lightGray
        // ButtonBarItemのフォントサイズ
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        // 選択中のButtonBarインジケーターの色
        settings.style.selectedBarBackgroundColor = UIColor.black
        // 選択中のButtonBarインジケーターの太さ
        settings.style.selectedBarHeight = 2.0
        // ButtonBarの左端の余白
        settings.style.buttonBarLeftContentInset = 8
        // ButtonBarの右端の余白
        settings.style.buttonBarRightContentInset = 8
        // Button内の余白
        settings.style.buttonBarItemLeftRightMargin = 32
        // スワイプやButtonBarItemタップ等でページを切り替えた時の動作
        changeCurrentIndexProgressive = { oldCell, newCell, progressPercentage, changeCurrentIndex, animated in
            // 変更されたか、選択前後のCellをアンラップ
            guard changeCurrentIndex, let oldCell = oldCell, let newCell = newCell else { return }
            // 選択前のセルの状態を指定
            oldCell.label.textColor = UIColor.lightGray
            // 選択後のセルの状態を指定する
            newCell.label.textColor = UIColor.black
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        //管理されるViewControllerを返す処理
        let firstVC = UIStoryboard(name: "FieldFirst", bundle: nil).instantiateInitialViewController() as! FieldFirstViewController
        let model1 = FieldFirstModel()
        let presenter1 = FieldFirstPresenter(view: firstVC, model: model1)
        firstVC.inject(presenter: presenter1)
        
        let secondVC = UIStoryboard(name: "FieldSecond", bundle: nil).instantiateInitialViewController() as! FieldSecondViewController
        let model2 = FieldSecondModel()
        let presenter2 = FieldSecondPresenter(view: secondVC, model: model2)
        secondVC.inject(presenter: presenter2)
        
        let thirdVC = UIStoryboard(name: "FieldThird", bundle: nil).instantiateInitialViewController() as! FieldThirdViewController
        let model3 = FieldThirdModel()
        let presenter3 = FieldThirdPresenter(view: thirdVC, model: model3)
        thirdVC.inject(presenter: presenter3)
                
        let childViewControllers:[UIViewController] = [firstVC, secondVC, thirdVC]
        return childViewControllers
    }

}

