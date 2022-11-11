//
//  LoginDataModel.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/09/08.
//

import Foundation


// MARK: - LoginDataModel
struct LoginDataModel: Codable {
//    let success: Bool
    let location, msg: String?
    let data: UserData?
    
    enum CodingKeys: String, CodingKey {
//        case success
        case location
        case msg
        case data
    }
    
    init(from decoder : Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        location = (try? values.decode(String.self, forKey: .location)) ?? ""
        msg = (try? values.decode(String.self, forKey: .msg)) ?? ""
        data = (try? values.decode(UserData.self, forKey: .data)) ?? nil
    }
}

// MARK: - UserData
struct UserData: Codable {
//    let userID: Int
//    let userNickname, token: String
    let refreshToken, accessToken: String
    
    enum CodingKeys: String, CodingKey {
        
        case refreshToken = "refreshToken"
        case accessToken = "accessToken"
    }
    
//    enum CodingKeys: String, CodingKey {
//        case userID = "UserId"
//        case userNickname = "user_nickname"
//        case token
//    }
}
