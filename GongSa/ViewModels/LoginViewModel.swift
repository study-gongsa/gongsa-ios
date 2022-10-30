//
//  LoginViewModel.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/08/17.
//

import UIKit
import Foundation

class LoginViewModel {
    
//    //    private let loginManager: LoginManger
//    private let loginManager : LoginManager
////    static let shared = LoginManager()
//    init(loginManager: LoginManager) {
//        self.loginManager = loginManager
//    }
    
    private var userLogin =  UserLogin() {
        didSet {
            email = userLogin.email
            password = userLogin.password
        }
    }
    
    private var email = ""
    private var password = ""
    
    var userLoginInputErrorMessage: Observable<String> = Observable("")
    var isEmailTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    
    // Update UserLogin
    func updateUserLogin(email: String, password: String, otp: String? = nil) {
        userLogin.email = email
        userLogin.password = password
    }
    
    
    func login() {
        
        
        
        
        
//        loginManager.loginWithUserInfos(email: email, passwd: passwd) { [weak self] (error) in
//            guard let error = error else {
//                return
//            }
//
//            self?.errorMessage.value = error.localizedDescription
//        }
    }
    
    func userLoginInput() -> UserLoginInputStatus {
            if email.isEmpty && password.isEmpty {
//                credentialsInputErrorMessage.value = "Please provide username and password."
                return .Incorrect
            }
            if email.isEmpty {
                userLoginInputErrorMessage.value = "이메일을 입력해주세요"
                isEmailTextFieldHighLighted.value = true
                return .Incorrect
            }
            if password.isEmpty {
                userLoginInputErrorMessage.value = "비밀번호를 입력해주세요"
                isPasswordTextFieldHighLighted.value = true
                return .Incorrect
            }
            return .Correct
        }
    
}

extension LoginViewModel {
    enum UserLoginInputStatus {
        case Correct
        case Incorrect
    }
}
