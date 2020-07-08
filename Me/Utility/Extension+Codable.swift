//
//  Extension+Codable.swift
//  Me
//
//  Created by NDPhu on 6/30/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import Foundation

//Encode
extension Encodable {
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

extension Encodable {
    /// Converting object to postable dictionary
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let json = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return json
    }
}

//Decode
extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
