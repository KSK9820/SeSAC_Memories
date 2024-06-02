//
//  ReuseIdentifiable.swift
//  0524
//
//  Created by 김수경 on 6/1/24.
//

import Foundation

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
