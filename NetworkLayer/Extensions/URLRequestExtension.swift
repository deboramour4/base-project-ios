//
//  URLRequestExtension.swift
//  TheFinal
//
//  Created by Mateus Sales on 24/09/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

// MARK: - makes an URL Request
extension URLRequest {

    /// Expect to receive a Service as param
    ///
    init(service: Service) {
        if let urlComponents = URLComponents(service: service),
            let url = urlComponents.url {
            self.init(url: url)

            self.httpMethod = service.method.rawValue

            service.headers?.forEach { key, value in
                addValue(value, forHTTPHeaderField: key)
            }

            if case let .requestWithBody(payload) = service.task,
                service.parametersEncoding == .json {
                
                if let payloadEncoded = payload.asData() {
                    self.httpBody = payloadEncoded
                }
            }
            
            if case let .requestParameters(parameters) = service.task,
                service.parametersEncoding == .json {
                
                if let parametersEncoded = parameters.asData() {
                    self.httpBody = parametersEncoded
                }
            }

        } else {
            self.init(url: URL(fileURLWithPath: ""))
        }
    }
}
