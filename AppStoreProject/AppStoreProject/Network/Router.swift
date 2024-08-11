//
//  Router.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/11/24.
//

import Foundation
import Alamofire

enum Router {
    case software(term: String)
}

extension Router: TargetType {
    var baseURL: String {
        switch self {
        case .software:
            return "https://itunes.apple.com"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .software:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .software:
            return "/search"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .software(let term):
            return [
                URLQueryItem(name: "term", value: term),
                URLQueryItem(name: "country", value: "kr"),
                URLQueryItem(name: "entity", value: "software"),
            ]
        }
    }
    
    
}

