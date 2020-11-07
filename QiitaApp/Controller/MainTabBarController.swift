//
//  MainTabBarController.swift
//  QiitaApp
//
//  Created by Ayuki Nishioka on 2020/11/06.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var viewControllers = [UIViewController]()
        let fieldViewController = UIStoryboard(name: "Field", bundle: nil).instantiateInitialViewController()
        fieldViewController?.tabBarItem = UITabBarItem(title: "フィールド", image: UIImage(named: "list"), tag: 0)
        viewControllers.append(fieldViewController!)
        
        let searchViewController = UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController()
        searchViewController?.tabBarItem =  UITabBarItem(title: "サーチ", image: UIImage(named: "search"), tag: 0)
        viewControllers.append(searchViewController!)
        
        self.setViewControllers(viewControllers, animated: false)

    }
        
}
