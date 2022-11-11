//
//  MyQuestionsResponse.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/11/12.
//

import Foundation

// MARK: - MyQuestionsResponse
struct MyQuestionsResponse: Codable {
    let location, msg: String?
    let data: QuestionsDataClass
}

// MARK: - QuestionsDataClass
struct QuestionsDataClass: Codable {
    let questionList: [QuestionList]
}

// MARK: - QuestionList
struct QuestionList: Codable {
    let questionUID: Int
    let title, content, answerStatus: String
    let createdAt: Int
}
