//
//  Extension+UIViewController.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/12/24.
//

import UIKit

extension UIViewController {
    static func ListCollectionView() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let widthSize = UIScreen.main.bounds.width - 20
        let heightSize = UIScreen.main.bounds.height * 0.4
        
        layout.itemSize = CGSize(width: widthSize, height: heightSize)
        layout.minimumLineSpacing = 30
        return layout
    }
    
    static func screenshotCollectionView() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let widthSize = UIScreen.main.bounds.width * 0.7
        let heightSize = UIScreen.main.bounds.height * 0.6
    
        layout.itemSize = CGSize(width: widthSize, height: heightSize)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
