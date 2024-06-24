//
//  NetworkManager.swift
//  0604
//
//  Created by 김수경 on 6/20/24.
//

import Foundation
import Alamofire

// 역할에 따른 네이밍: Service, Manager,
// callRequest, getLotto, fetchLotto, requestLotto
final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func getLotto(_ count: String, completion: @escaping (LottoModel, [String]) -> Void) {
        guard let url = URL(string: APIURL.lottery(count).urlString) else { return }
        
        AF.request(url).responseDecodable(of: LottoModel.self) { response in
            switch response.result {
            case .success(let data):
                var selectedNumbers = [data.drwtNo1, data.drwtNo2, data.drwtNo3, data.drwtNo4, data.drwtNo5, data.drwtNo6, data.bnusNo].map { String($0) }
                selectedNumbers.insert("+", at: 6)
                completion(data, selectedNumbers)
            case .failure(let error):
                print(error)
            }
        }
    }
}
