//
//  HTTPTask.swift
//  TheFinal
//
//  Created by Mateus Sales on 24/09/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

public typealias Parameters = [String: String]

public enum HTTPTask {
    case requestPlain
    case requestParameters(Parameters)
    case requestWithBody(Encodable)
}
