//
//  TMDBTabBarController.swift
//  0604
//
//  Created by 김수경 on 7/1/24.
//

import UIKit

final class TMDBTabBarController: UITabBarController {
    
    override func viewDidLoad() {
         super.viewDidLoad()
         
         tabBar.tintColor = .black
         tabBar.unselectedItemTintColor = .lightGray
         
         let nav1 = UINavigationController(rootViewController: SearchViewController())
         nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 0)
         
         let nav2 = UINavigationController(rootViewController: TrendViewController())
         nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "flame"), tag: 1)
         
         setViewControllers([nav1, nav2], animated: false)
     }

}

