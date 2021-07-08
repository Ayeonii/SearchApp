//
//  TabBarViewController.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/19.
//

import UIKit

private enum TabMode : Int {
    case search = 0
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    private var searchTabVC : UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.setTabbarVC()
        self.setTabbarItem()
    }
    
    func setTabbarVC () {
        self.searchTabVC = SearchMainViewController(nibName: "SearchMainViewController", bundle: nil)

        self.viewControllers = [UINavigationController(rootViewController: searchTabVC!)]
    }
    
    func setTabbarItem() {
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .black
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        let searchTab = self.tabBar.items![TabMode.search.rawValue]
        searchTab.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)

        searchTab.image = UIImage(systemName : "search")
        searchTab.title = "검색"
    }
}
