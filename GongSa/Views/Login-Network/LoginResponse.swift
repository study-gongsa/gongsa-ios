//
//  LoginResponse.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/09/06.
//

import Foundation


// MARK: - LoginResponse
struct LoginResponse: Codable {
    let location, msg: String?
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let accessToken, refreshToken: String
}

/*
// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }
//    func hash(into hasher: inout Hasher) -> Int {
//        return 0
//    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

*/
