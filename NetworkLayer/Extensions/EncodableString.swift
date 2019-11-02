//
//  EncodableString.swift
//  TheFinal
//
//  Created by Mateus Sales on 24/09/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

// MARK: - Encodable extension
extension Encodable {

    /// Convert some data in String dictionary
    ///
    /// - Returns: serializable dictionary
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(
                with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
    }

    /// Encode to data
    ///
    /// - Returns: data type
    func asData() -> Data? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(Constants.apiDateFormatter)
        let data = try? encoder.encode(self)
        return data
    }
}

class Constants {
    static var apiDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        formatter.calendar = Calendar.current
        formatter.locale = Locale.current
        return formatter
    }
}
