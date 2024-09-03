//
//  Market.swift
//  SwiftUIPractice
//
//  Created by 김수경 on 9/3/24.
//

import Foundation

typealias Markets = [Market]

struct Market: Hashable, Codable {
    let market, koreanName, englishName: String
    var status: Bool = false

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
