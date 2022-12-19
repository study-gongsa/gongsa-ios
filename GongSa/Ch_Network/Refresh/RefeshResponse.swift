//
//  RefeshResponse.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/12/03.
//

import Foundation

// MARK: - RefeshResponse
struct RefeshResponse: Codable {
    let location, msg: String?
    let data: RefreshDataClass
}

// MARK: - DataClass
struct RefreshDataClass: Codable {
    let accessToken: String
}

