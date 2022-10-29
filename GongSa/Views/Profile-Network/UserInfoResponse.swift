//
//  UserInfoResponse.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/10/30.
//

import Foundation

// MARK: - UserInfoRespone
struct UserInfoResponse: Codable {
    let location, msg: String?
    let data: UserDataClass
}

// MARK: - DataClass
struct UserDataClass: Codable {
    let imgPath, nickname, totalStudyTime: String
    let level: Int
    let percentage: Double
}
