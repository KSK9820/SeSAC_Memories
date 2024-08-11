//
//  ReuseIdentifiable.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/11/24.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifiable {}
