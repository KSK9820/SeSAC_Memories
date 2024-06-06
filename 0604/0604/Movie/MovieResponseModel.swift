//
//  MovieResponseModel.swift
//  0604
//
//  Created by 김수경 on 6/6/24.
//

import Foundation

struct MovieResponseModel: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}
