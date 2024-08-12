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
    
    func callRequest(date: String) -> Single<Result<MovieModel, APIError>> {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.movie)&targetDt=\(date)"
        
        return Single.create { single -> Disposable in
            guard let url = URL(string: url) else {
                single(.success(.failure(.invalidURL)))
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    single(.success(.failure(.unknownResponse)))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    single(.success(.failure(.statusError)))
                    return
                }
                if let data,
                   let appData = try? JSONDecoder().decode(MovieModel.self, from: data) {
                    single(.success(.success(appData)))
                } else {
                    single(.success(.failure(.unknownResponse)))
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
