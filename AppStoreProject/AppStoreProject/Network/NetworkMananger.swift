//
//  NetworkMananger.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/11/24.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func getSearchData(_ term: String) -> Single<AppStoreDTO>{
        return Single<AppStoreDTO>.create { single in
            do {
                let request = try Router.software(term: term).asURLRequest()
                AF.request(request).responseDecodable(of: AppStoreDTO.self) {
                    response in
                    switch response.result {
                    case .success(let data):
                        single(.success(data))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            } catch {
                single(.failure(error))
            }
            
            return Disposables.create()
        }
    }

}
