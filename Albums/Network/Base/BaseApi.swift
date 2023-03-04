//
//  BaseApi.swift
//  Albums
//
//  Created by Mohamed Khaled on 02/03/2023.
//

import Foundation
import Moya

protocol BaseAPI {
    associatedtype router: BaseEndpoint
    func fetchData<T: Codable>(target: router, onComplete: @escaping (Result<T, Error>) -> Void)
}

extension BaseAPI {
    
    func fetchData<T: Codable>(target: router, onComplete: @escaping (Result<T, Error>) -> Void) {
        let provider = MoyaProvider<router>()
        provider.request(target, callbackQueue: DispatchQueue.main) { response in
            do {
                guard let statusCode = try? response.get().statusCode else {return}
                switch statusCode {
                case 200:
                    let model = try JSONDecoder().decode(T.self, from: response.get().data)
                    onComplete(.success(model))
                default:
                    onComplete(.failure(NetworkError.somethingWentWrong))
                }
            } catch {
                onComplete(.failure(NetworkError.somethingWentWrong))
            }
        }
    }
}

