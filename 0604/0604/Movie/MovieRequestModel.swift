//
//  MovieRequestModel.swift
//  0604
//
//  Created by 김수경 on 6/7/24.
//

import Foundation

struct MovieRequestModel: Encodable {
    let targetDt: String
    let key = APIKey.movie.apikey
}
