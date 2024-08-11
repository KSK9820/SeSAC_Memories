//
//  MovieNetworkManager.swift
//  SeSACRxThreads
//
//  Created by 김수경 on 8/9/24.
//

import Foundation
import RxSwift

final class MovieNetworkManager {
    
    static let shared = MovieNetworkManager()
    
    private init() {}
    
    func callRequest(date: String) -> Single<MovieModel> {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.movie)&targetDt=\(date)"
        
        return Single<MovieModel>.create { single in
            guard let url = URL(string: url) else {
                single(.failure(APIError.invalidURL))
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    single(.failure(APIError.unknownResponse))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    single(.failure(APIError.statusError))
                    return
                }
                if let data,
                   let appData = try? JSONDecoder().decode(MovieModel.self, from: data) {
                    single(.success(appData))
                } else {
                    single(.failure(APIError.unknownResponse))
                }
            }.resume()
            
            return Disposables.create()
        }
    }
    
}

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
}
