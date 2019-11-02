//
//  URLSessionProvider.swift
//  TheFinal
//
//  Created by Mateus Sales on 24/09/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

public final class URLSessionProvider: Provider {

    private var session: URLSession

    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    public func request<T: Decodable>(
        type: T.Type, service: Service, completion: @escaping (Result<T, Error>) -> Void) {

        let request = URLRequest(service: service)

        let task = self.session.dataTask(with: request) { (result) in
            self.handleResult(result: result, error: ErrorResponse.self, completion: completion)
        }

        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
    }
    
    private func handleResult<T: Decodable, E: Error & Decodable>(
        result: Result<(URLResponse, Data), Error>, error: E.Type, completion: (Result<T, Error>) -> Void) {

        switch result {
        case .failure(let error):
            completion(.failure(error))
        case .success(let response, let data):
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError<E>.noJSONData))
            }
            
            if let dataString = String(bytes: data, encoding: String.Encoding.utf8) as? T {
                completion(.success((dataString))) //If T is a string, just return it
            } else {
                let decoder = JSONDecoder()
                switch httpResponse.statusCode {
                case 200...299:
                    decoder.dateDecodingStrategy = .formatted(Constants.apiDateFormatter)
                    do {
                        let model = try decoder.decode(T.self, from: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(NetworkError<E>.parsedData))
                    }
                case 400...499:
                    let error = try? decoder.decode(E.self, from: data)
                    completion(.failure(NetworkError<E>.apiError(error)))
                default:
                    completion(.failure(NetworkError<E>.unknown))
                }
            }
        }
    }
}
