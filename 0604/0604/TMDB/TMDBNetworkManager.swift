//
//  TMDBNetworkManager.swift
//  0604
//
//  Created by 김수경 on 6/24/24.
//

import Foundation
import Alamofire

final class TMDBNetworkManager {
    
    static let shared = TMDBNetworkManager()
    
    private init() { }
    
    func getData<T: Decodable>(url: APIURL, reponseType: T.Type, completion: @escaping (T) -> Void) {
        let url = url.urlString
        let header: HTTPHeaders = [
            "Authorization" : APIKey.tmdb.apikey,
            "access" : "application/json"
        ]
        
        AF.request(url, headers: header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
