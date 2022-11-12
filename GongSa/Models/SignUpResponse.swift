//
//  SignUpResponse.swift
//  GongSa
//
//  Created by taechan on 2022/08/18.
//

import Foundation

/// API response for Sign up
struct SignUpResponse: Codable {
    let location: String?
    let msg: String?
    let data: TokenResponse?

}

struct TokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
