//
//  NetworkManager.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

final class NetworkManager: NSObject {

    static let shared = NetworkManager()

    private override init() { }

}

extension NetworkManager {

    func request<T: Codable>(
        api: APIURL.Kakao,
        completion: @escaping (Result<T, APIError>) -> ()
    ) {
        guard let url = api.url else {
            return completion(.failure(.invalidURL))
        }

        var request = URLRequest(
            url: url,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: 10
        )
        request.httpHeader = APIHeader.Kakao.header
        request.method = .get

        let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)

        URLSession.request(session, endpoint: request) { (data: T?, error) in
            if let error {
                return completion(.failure(error))
            }
            guard let data else {
                return completion(.failure(.noData))
            }
            completion(.success(data))
        }
    }

}

extension NetworkManager: URLSessionDelegate {

}
