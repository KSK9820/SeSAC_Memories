//
//  ReuseIdentifiable.swift
//  SeSACRxThreads
//
//  Created by 김수경 on 8/3/24.
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

extension UITableViewCell: ReuseIdentifiable {}
