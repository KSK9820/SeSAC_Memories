//
//  CreditType.swift
//  0604
//
//  Created by 김수경 on 6/11/24.
//

import Foundation

struct CreditType: Decodable {
    let id: Int
    let cast: [Cast]?
}

struct Cast: Decodable {
    let name: String?
    let profilePath: String?
    let character: String?

    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case character
    }
}
