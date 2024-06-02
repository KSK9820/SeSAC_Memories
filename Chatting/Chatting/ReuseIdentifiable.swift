//
//  ReuseIdentifiable.swift
//  Chatting
//
//  Created by 김수경 on 6/2/24.
//

import Foundation

protocol ReuseIdentifiable {
    static var identifier: String { get }
}

extension ReuseIdentifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
