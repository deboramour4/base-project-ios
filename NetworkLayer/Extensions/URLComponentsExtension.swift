//
//  URLComponetnsExtension.swift
//  TheFinal
//
//  Created by Mateus Sales on 24/09/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

 // MARK: - Responsible for handle url components
 extension URLComponents {

     /// Initializer
     ///
     /// - Parameter service: receive a service

     init?(service: Service) {
         let url = service.baseURL.appendingPathComponent(service.path)
         self.init(url: url, resolvingAgainstBaseURL: false)

         guard case let .requestParameters(parameters) = service.task,
             service.parametersEncoding == .url else {
                 return
         }

         self.queryItems = parameters.map { key, value in
             return URLQueryItem(name: key, value: String(describing: value))
         }
     }
 }
