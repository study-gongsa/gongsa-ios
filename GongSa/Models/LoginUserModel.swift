//
//  LoginUserModel.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/08/19.
//

import Foundation

class LoginUserModel {
    
    struct User {
        var email: String
        var password: String
    }
    
    // 아이디 형식 검사
    func isValidEmail(id: String) -> Bool {
        let emailRegEx = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: id)
    }
    
    // 비밀번호 형식 검사
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^([a-zA-Z0-9!@#$%^&amp;*()_+]{8,16})$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
}
