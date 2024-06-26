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
   
    private let session: Session
    
    private init() {
        let retryHander = TMDBNetworkRetrier()
        self.session = Session(interceptor: retryHander)
    }
    
    func getData<T: Decodable>(url: APIURL, reponseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        session.request(url.urlString, headers: url.header) { $0.timeoutInterval = 1 }
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

class TMDBNetworkRetrier: RequestInterceptor {
    
    private let maxRetryCount = 3
    var retryCount = 0
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (Alamofire.RetryResult) -> Void) {
       
        let retryCount = request.retryCount
        if let afError = error.asAFError,
            afError.isSessionTaskError {
            if retryCount < maxRetryCount {
                completion(.retry)
                return
            }
        }
        
        completion(.doNotRetry)
    }
    
}
