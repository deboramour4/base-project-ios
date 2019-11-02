//
//  NetworkError.swift
//  TheFinal
//
//  Created by Mateus Sales on 24/09/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

public enum NetworkError<E: Error & Decodable>: Error {
    case unknown
    case parsedData
    case noJSONData
    case apiError(E?)
}
