//
//  StudyroomQuestionRequest.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/11/12.
//

import Foundation

// MARK: - StudyroomQuestionRequest
struct StudyroomQuestionRequest: Codable {
    let groupUID: Int
    let title, content: String
}
