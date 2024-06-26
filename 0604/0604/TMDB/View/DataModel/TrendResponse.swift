//
//  TrendResponse.swift
//  0604
//
//  Created by 김수경 on 6/10/24.
//

import Foundation

struct TrendResponse: Decodable {
    var page: Int
    var results: [TrendResult]
    let total_pages: Int
}

struct TrendResult: Codable {
    let id: Int
    let originalTitle: String?
    let overview: String
    let posterPath: String?
    let mediaType: String?
    let releaseDate: String?
    let voteAverage: Double
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, overview
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
    }
}
