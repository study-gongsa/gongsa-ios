//
//  RegisterViewModel.swift
//  GongSa
//
//  Created by taechan on 2022/08/03.
//

import UIKit

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

class RegisterViewModel {

    var user: Observable<UserRegisterData>

    var termsOfService: Observable<Bool>
    var privacyPolicy: Observable<Bool>
    var eventReceive: Observable<Bool>

    // MARK: - Validation Functions

    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                    "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: user.value.email)
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
        // MARK: - TODO: 올바른 닉네임 정규표현식 작성해야함
        let nicknameTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return nicknameTest.evaluate(with: user.value.nickname)
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
        return isSignUpComplete && isAllChecked ? true : false
    }

    // MARK: - Validation Prompt Strings

    var emailPrompt: String {
        if user.value.email == "" { return "" }
        if isEmailValid() {
            return ""
        } else {
            return "잘못된 형식의 이메일 주소입니다."
        }
    }

    var passwordPrompt: String {
        if user.value.password == "" { return "" }
        if isPasswordValid() {
            return ""
        } else {
            return "잘못된 형식의 비밀번호입니다."
        }
    }

    var passwordConfirmPrompt: String {
        if user.value.passwordConfirm == "" { return "" }
        if isPasswordConfirmValid() {
            return ""
        } else {
            return "잘못된 형식의 비밀번호입니다."
        }
    }

    var nicknamePrompt: String {
        if user.value.nickname == "" { return "" }
        if isNicknameValid() {
            return ""
        } else {
            return "잘못된 형식의 닉네임입니다."
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
        if user.value.nickname == "" { return UIColor.gsDarkGray.cgColor }
        return isEmailValid() ? UIColor.gsLightGray.cgColor : UIColor.gsRed.cgColor
    }

    var passwordTextFieldBorderColor: CGColor {
        if user.value.password == "" { return UIColor.gsDarkGray.cgColor }
        return isPasswordValid() ? UIColor.gsLightGray.cgColor : UIColor.gsRed.cgColor
    }

    var passwordConfirmTextFieldBorderColor: CGColor {
        if user.value.passwordConfirm == "" { return UIColor.gsDarkGray.cgColor }
        return isPasswordConfirmValid() ? UIColor.gsLightGray.cgColor : UIColor.gsRed.cgColor
    }

    var nicknameTextFieldBorderColor: CGColor {
        if user.value.nickname == "" { return UIColor.gsDarkGray.cgColor }
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
    }

    // MARK: - sign up

    func signUp() {
        // 회원가입 후 값 초기화
        self.user = Observable(UserRegisterData(email: "", password: "", passwordConfirm: "", nickname: ""))

        self.termsOfService = Observable(false)
        self.privacyPolicy = Observable(false)
        self.eventReceive = Observable(false)
    }
}
