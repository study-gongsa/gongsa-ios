//
//  StudyGroupListsResponse.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/11/11.
//

import Foundation

// MARK: - StudyGroupListsResponse
struct StudyGroupListsResponse: Codable {
    let location, msg: String?
    let data: StudyGroupDataClass
}

// MARK: - DataClass
struct StudyGroupDataClass: Codable {
    let groupRankList: [GroupRankList]
}

// MARK: - GroupRankList
struct GroupRankList: Codable {
    let groupUID: Int
    let name: String
    let members: [Member]
}

// MARK: - Member
struct Member: Codable {
    let userUID: Int
    let nickname, imgPath, studyStatus, totalStudyTime: String
    let ranking: Int
}
