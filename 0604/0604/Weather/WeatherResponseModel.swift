//
//  WeatherResponseModel.swift
//  0604
//
//  Created by 김수경 on 6/7/24.
//

import Foundation

struct WeatherResponseModel: Decodable {
    let weather: [Weather]
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
