//
//  Service.swift
//  TheFinal
//
//  Created by Mateus Sales on 24/09/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

public typealias Headers = [String: String]

public protocol Service {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}
