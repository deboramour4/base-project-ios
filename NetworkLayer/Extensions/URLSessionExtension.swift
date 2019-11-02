//
//  URLSessionExtension.swift
//  TheFinal
//
//  Created by Mateus Sales on 24/09/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

// MARK: - Makes a URLSession
extension URLSession {

    /// DataTask
    ///
    /// - Parameters:
    ///   - url: expect some url as value
    ///   - result: expect a
    /// - Returns: return a response containing response and data

    func dataTask(
        with url: URLRequest,
        result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {

        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
