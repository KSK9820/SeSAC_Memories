//
//  TabBarController.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/11/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .gray
        
        let nav1VC = UIViewController()
        let nav2VC = UIViewController()
        let nav3VC = UIViewController()
        let nav4VC = UIViewController()
        let nav5VC = SearchViewController()
        
        
        let nav1 = UINavigationController(rootViewController: nav1VC)
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "book"), tag: 0)
        
        let nav2 = UINavigationController(rootViewController: nav2VC)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gamecontroller"), tag: 1)
        
        let nav3 = UINavigationController(rootViewController: nav3VC)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "app"), tag: 2)
        
        let nav4 = UINavigationController(rootViewController: nav4VC)
        nav4.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "star"), tag: 3)
        
        let nav5 = UINavigationController(rootViewController: nav5VC)
        nav5.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 4)
        
        
        setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: false)
        selectedIndex = 4
    }
    
}
