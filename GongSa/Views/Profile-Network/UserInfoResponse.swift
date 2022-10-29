//
//  UserInfoResponse.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/10/30.
//

import Foundation

// MARK: - UserInfoResponse
struct UserInfoResponse: Codable {
    let location, msg: String?
    let data: UserDataClass
}

// MARK: - UserDataClass
struct UserDataClass: Codable {
    let imgPath, nickname, totalStudyTime: String
    let level: Int
    let percentage: Double
}

