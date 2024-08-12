//
//  MovieModel.swift
//  SeSACRxThreads
//
//  Created by 김수경 on 8/9/24.
//

import Foundation

struct MovieModel: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}
