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
    
    private var loginUserModel = LoginUserModel()
    
    private var email = ""
    private var password = ""
    
    var userLoginInputErrorMessage: Observable<String> = Observable("")
    var isEmailTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    
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
    
    
    
    // Update UserLogin
    func updateUserLogin(email: String, password: String, otp: String? = nil) {
        userLogin.email = email
        userLogin.password = password
//        completionLoginBtn(isOn: true)
    }
    
    
    func login() {
        LoginService.shared.login(email: email, passwd: password) { result in
            switch result
            {
            case.success(let userdata):
                print("로그인 통신 성공")
                
                if let data = userdata as? LoginDataClass {
                    
                    let accessToken = data.accessToken
                    let refreshToken = data.refreshToken
                    let gongsaKeychain = KeyChain.shared
                    gongsaKeychain.create(key: "accessToken", token: accessToken)
                    gongsaKeychain.create(key: "refreshToken", token: refreshToken)
//                    KeyChain.shared.create(key: "accessToken", token: accessToken)
                    print("토큰 저장 성공")
                    
                    
                }
                //                self.navigationController?.pushViewController(HomeViewController(), animated: true)
//                print(KeyChain.shared.read(key: "accessToken")!)
            case .requestErr(let msg):
                print("로그인 에러")
                if let msg = msg as? String {
                    DispatchQueue.main.async {
                        self.isEmailTextFieldHighLighted.value = true
                        self.userLoginInputErrorMessage.value = "\(msg)"
                    }
                }
            default:
                print("error")
            }
        }
    }
    
    func userLoginInput() -> UserLoginInputStatus {
        
        if email.isEmpty && password.isEmpty {
//                            credentialsInputErrorMessage.value = "Please provide username and password."
            isEmailTextFieldHighLighted.value = true
            isPasswordTextFieldHighLighted.value = true
            return .Incorrect
        }
        // 이메일 칸 비어있으면
        if email.isEmpty {
            userLoginInputErrorMessage.value = "이메일을 입력해주세요"
            isEmailTextFieldHighLighted.value = true
            
            return .Incorrect
        }
        // 비밀번호 칸 비어있으면
        if password.isEmpty {
            userLoginInputErrorMessage.value = "비밀번호를 입력해주세요"
            isPasswordTextFieldHighLighted.value = true
            
            return .Incorrect
        }
        // 이메일 형식 검사
        if isValidEmail(id: email) == false {
            userLoginInputErrorMessage.value = "올바르지 않은 이메일 형식입니다"
            isEmailTextFieldHighLighted.value = true
//            completionLoginBtn(isOn: false)
            return .Incorrect
        }
        
        if isValidPassword(pwd: password) == false {
            userLoginInputErrorMessage.value = "올바른 비밀번호를 입력해주세요"
            isPasswordTextFieldHighLighted.value = true
//            completionLoginBtn(isOn: false)
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
