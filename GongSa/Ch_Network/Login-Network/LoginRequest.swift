//
//  LoginRequest.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/09/06.
//

import Foundation

// MARK: - LoginRequest
struct LoginRequest: Codable {
    let email, passwd: String
}
