//
//  StudyroomQuestionResponse.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/11/12.
//


import Foundation

// MARK: - StudyroomQuestionResponse
struct StudyroomQuestionResponse: Codable {
    let location, msg: String?
    let data: QuestionDataClass
}

// MARK: - DataClass
struct QuestionDataClass: Codable {
    let questionUID: Int
}
