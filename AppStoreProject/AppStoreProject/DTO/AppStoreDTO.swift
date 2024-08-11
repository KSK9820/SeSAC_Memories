//
//  AppStoreDTO.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/11/24.
//

import Foundation

struct AppStoreDTO: Codable {
    let resultCount: Int
    let results: [AppStoreResult]
}
struct AppStoreResult: Codable {
    let screenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let averageUserRating: Double
    let trackCensoredName: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let description: String
    let releaseNotes: String?
    let version: String
    
    enum CodingKeys: String, CodingKey {
        case screenshotUrls
        case artworkUrl60
        case artworkUrl512
        case artworkUrl100
        case averageUserRating
        case trackCensoredName
        case artistID = "artistId"
        case artistName
        case genres
        case description
        case releaseNotes
        case version
    }
}
