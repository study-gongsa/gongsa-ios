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
    let data: LoginDataClass
}
// MARK: - LoginDataClass
struct LoginDataClass: Codable {
    let accessToken, refreshToken: String
}
