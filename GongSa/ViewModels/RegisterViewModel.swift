//
//  RegisterViewModel.swift
//  GongSa
//
//  Created by taechan on 2022/08/03.
//

import UIKit
import Alamofire

struct UserRegisterData {
    var email: String
    var password: String
    var passwordConfirm: String
    var nickname: String

    init(email: String, password: String, passwordConfirm: String, nickname: String) {
        self.email = email
        self.password = password
        self.passwordConfirm = passwordConfirm
        self.nickname = nickname
    }
}

enum PromptMessage: String {
    case emailFormatInvalid = "잘못된 이메일 형식입니다."
    case emailAlreadyExists = "중복된 이메일 입니다."
    case passwordFormatInvalid = "잘못된 비밀번호 형식입니다."
    case passwordConfirmFormatInvalid = "비밀번호가 일치하지 않습니다."
    case nicknameFormatInvalid = "잘못된 닉네임 형식입니다."
    case nicknameAlreadyExists = "중복된 닉네임 입니다."
}

class RegisterViewModel {

    var user: Observable<UserRegisterData>

    var termsOfService: Observable<Bool>
    var privacyPolicy: Observable<Bool>
    var eventReceive: Observable<Bool>

    var registerButton: Observable<Bool>

    // MARK: - Validation Functions

    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                    "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")

        return emailTest.evaluate(with: user.value.email) && !doesEmailExist
    }

    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^([a-zA-Z0-9!@#$%^&amp;*()_+]{8,16})$")
        return passwordTest.evaluate(with: user.value.password)
    }

    func isPasswordConfirmValid() -> Bool {
        return user.value.password == user.value.passwordConfirm
    }

    func isNicknameValid() -> Bool {
        let nicknameTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^[가-힣A-Za-z0-9]{1,10}$")
        return nicknameTest.evaluate(with: user.value.nickname) && !doesNicknameExist
    }

    var isSignUpComplete: Bool {
        if !isPasswordConfirmValid() ||
            !isPasswordValid() ||
            !isEmailValid() ||
            !isNicknameValid() {
            return false
        }
        return true
    }

    var isAllChecked: Bool {
        if !termsOfService.value ||
            !privacyPolicy.value ||
            !eventReceive.value {
            return false
        }
        return true
    }

    var shouldEnableRegisterButton: Bool {
        return isSignUpComplete && termsOfService.value && privacyPolicy.value ? true : false
    }

    // MARK: - Duplicate Check

    var doesEmailExist: Bool {
        return emailDuplicateMessage != nil
    }

    var doesNicknameExist: Bool {
        return nicknameDuplicateMessage != nil
    }

    var emailDuplicateMessage: String?

    var nicknameDuplicateMessage: String?

    // MARK: - Validation Prompt Strings

    var emailPrompt: String? {
        if user.value.email == "" { return "" }
        if isEmailValid() {
            return ""
        } else {
//            debugPrint("DEBUG - emailDuplicateMessage", emailDuplicateMessage)
            return doesEmailExist ? PromptMessage.emailAlreadyExists.rawValue : PromptMessage.emailFormatInvalid.rawValue
        }
    }

    var passwordPrompt: String? {
        if user.value.password == "" { return "" }
        if isPasswordValid() {
            return ""
        } else {
            return PromptMessage.passwordFormatInvalid.rawValue
        }
    }

    var passwordConfirmPrompt: String? {
        if user.value.passwordConfirm == "" { return "" }
        if isPasswordConfirmValid() {
            return ""
        } else {
            return PromptMessage.passwordConfirmFormatInvalid.rawValue
        }
    }

    var nicknamePrompt: String? {
        if user.value.nickname == "" { return "" }
        if isNicknameValid() {
            return ""
        } else {
            debugPrint("DEBUG - nicknameDuplicateMessage", nicknameDuplicateMessage)
            return doesNicknameExist ? PromptMessage.nicknameAlreadyExists.rawValue : PromptMessage.nicknameFormatInvalid.rawValue
        }
    }

    // MARK: - To/Not to show prompt

    var hideEmailPrompt: Bool {
        return isEmailValid() ? true : false
    }

    var hidePasswordPrompt: Bool {
        return isPasswordValid() ? true : false
    }

    var hidePasswordConfirmPrompt: Bool {
        return isPasswordConfirmValid() ? true : false
    }

    var hideNicknamePrompt: Bool {
        return isNicknameValid() ? true : false
    }

    // MARK: - TextField Border Color

    var emailTextFieldBorderColor: CGColor {
        if user.value.email == "" { return UIColor.gsLightGray.cgColor }
        return isEmailValid() ? UIColor.gsLightGray.cgColor : UIColor.gsRed.cgColor
    }

    var passwordTextFieldBorderColor: CGColor {
        if user.value.password == "" { return UIColor.gsLightGray.cgColor }
        return isPasswordValid() ? UIColor.gsLightGray.cgColor : UIColor.gsRed.cgColor
    }

    var passwordConfirmTextFieldBorderColor: CGColor {
        if user.value.passwordConfirm == "" { return UIColor.gsLightGray.cgColor }
        return isPasswordConfirmValid() ? UIColor.gsLightGray.cgColor : UIColor.gsRed.cgColor
    }

    var nicknameTextFieldBorderColor: CGColor {
        if user.value.nickname == "" { return UIColor.gsLightGray.cgColor }
        return isNicknameValid() ? UIColor.gsLightGray.cgColor : UIColor.gsRed.cgColor
    }

    // MARK: - Checkbox/Button Color

    var TOSColor: UIColor {
        termsOfService.value ? UIColor.gsGreen : UIColor.gsLightGray
    }

    var privacyColor: UIColor {
        privacyPolicy.value ? UIColor.gsGreen : UIColor.gsLightGray
    }

    var eventColor: UIColor {
        eventReceive.value ? UIColor.gsGreen : UIColor.gsLightGray
    }

    var registerButtonColor: UIColor {
        shouldEnableRegisterButton ? UIColor.gsGreen : UIColor.gsLightGray
    }

    // MARK: - init

    init() {
        self.user = Observable(UserRegisterData(email: "", password: "", passwordConfirm: "", nickname: ""))

        self.termsOfService = Observable(false)
        self.privacyPolicy = Observable(false)
        self.eventReceive = Observable(false)
        self.registerButton = Observable(false)
    }

    private func resetValues() {
        self.user = Observable(UserRegisterData(email: "", password: "", passwordConfirm: "", nickname: ""))

        self.termsOfService = Observable(false)
        self.privacyPolicy = Observable(false)
        self.eventReceive = Observable(false)
        self.registerButton = Observable(false)
    }

    // MARK: - API

    public func signUp(completion: @escaping (Result<Bool, APIError>) -> Void) {

        let params = [
            "email": user.value.email,
            "nickname": user.value.nickname,
            "passwd": user.value.password
        ]

        AuthService.shared.signUp(params: params) { response in

            if response.value?.location != nil {
                switch response.value?.location {
                case "email":
                    self.emailDuplicateMessage = response.value?.msg
                    self.registerButton.value  = true
                    self.emailDuplicateMessage = nil
                case "nickname":
                    self.nicknameDuplicateMessage = response.value?.msg
                    self.registerButton.value  = true
                    self.nicknameDuplicateMessage = nil
                default:
                    break
                }
            }
            if response.response?.statusCode == 400 {
                completion(.failure(APIError.invalidInput))
                return
            }
            if let data = response.value {
                completion(.success(true))
                self.resetValues()
                return
            }
        }
    }

    public func sendEmail(completion: @escaping (Result<Data, Error>) -> Void) {
        let params = [
            "email": user.value.email
        ]

        AuthService.shared.sendMail(params: params) { response in
            switch response {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
