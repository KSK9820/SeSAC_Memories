//
//  ReuseIdentifiable.swift
//  0604
//
//  Created by 김수경 on 6/6/24.
//

import UIKit

protocol ReuseIdentifiable {
    static var identifier: String { get }
}

extension ReuseIdentifiable {
    static var identifier: String {
        String(describing: self)
    }
}


extension UIView: ReuseIdentifiable { }
