//
//  Provider.swift
//  TheFinal
//
//  Created by Mateus Sales on 24/09/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

public protocol Provider {
    func request<T: Decodable>(
        type: T.Type, service: Service, completion: @escaping (Result<T, Error>) -> Void)
}
