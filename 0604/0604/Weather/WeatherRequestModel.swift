//
//  WeatherRequestModel.swift
//  0604
//
//  Created by 김수경 on 6/7/24.
//

import Foundation

struct WeatherRequestModel: Encodable {
    let q: String
    let appid: String = APIKey.weather.apikey
}
