//
//  TargetType.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/11/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        var request = try URLRequest(url: url, method: method)
        
        if let queryItems {
            request.url?.append(queryItems: queryItems)
        }
        
        return request
    }
}
