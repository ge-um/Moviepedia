//
//  NetworkManager.swift
//  Moviepedia
//
//  Created by 금가경 on 8/3/25.
//

import Alamofire
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(url: String, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let url = URL(string: url)!
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": API.key
        ]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(.success(result))
                case .failure(let error):
                    print(error)
                }
            }
    }
}
