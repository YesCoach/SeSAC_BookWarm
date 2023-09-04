//
//  URLSession+.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

extension URLSession {

    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void

    @discardableResult
    func customDataTask(
        _ endPoint: URLRequest,
        completionHandler: @escaping completionHandler
    ) -> URLSessionDataTask {
        let task = dataTask(with: endPoint, completionHandler: completionHandler)
        task.resume()

        return task
    }

    static func request<T: Codable>(
        _ session: URLSession = .shared,
        endpoint: URLRequest,
        completion: @escaping ((T?, APIError?) -> Void)
    ) {
        session.customDataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {

                if let error {
                    print(error.localizedDescription)
                    completion(nil, .failedRequest)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                guard response.statusCode == 200 else {
                    completion(nil, .failedRequest)
                    return
                }
                guard let data else {
                    completion(nil, .noData)
                    return
                }

                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(result, nil)
                } catch {
                    print(error.localizedDescription) // 디코딩 오류가 발생한 키를 확인할 수 있음
                    completion(nil, .invalidData)
                }

            }
        }
    }
}
