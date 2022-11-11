//
//  PasswordResponse.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/09/29.
//

import Foundation

// MARK: - PasswordResponse
struct PasswordResponse: Codable {
    let location, msg, data: String?
}
