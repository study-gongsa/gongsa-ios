//
//  LoginViewController.swift
//  GongSa
//
//  Created by taechan on 2022/07/31.
//

import UIKit
import SnapKit
import SwiftUI
import Then

// MARK: - Canvas
@available(iOS 13.0, *)
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = LoginViewController
    
    func makeUIViewController(context: Context) -> LoginViewController {
        return LoginViewController()
    }
    
    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
    }
    
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}

class LoginViewController: UIViewController {
    
    //    private loginManager: LoginManager
    // MARK: - Properties
    
    var loginViewModel = LoginViewModel()
    var userModel = LoginUserModel()
    
    var emailStatus: Bool = false
    var passwordStatus: Bool = false
    
    var email: String = ""
    var password : String = ""
    
    // MARK: - Layout
    
    // 로그인 라벨
    lazy var titleLbl = UILabel().then {
        
        $0.backgroundColor = UIColor.clear
        $0.text = "로그인"
        $0.textColor = UIColor.black
        $0.font = UIFont(name: "Pretendard-Bold", size: 20)
        // text 정렬
        $0.textAlignment = .center
        
    }
    // 이메일 주소 -Label
    lazy var emailLbl: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.text = "이메일 주소"
        lbl.textColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1)
        lbl.font = UIFont(name: "Pretendard-Bold", size: 14)
        
        // 정렬
        lbl.textAlignment = NSTextAlignment.left
        return lbl
    }()
    // 이메일 텍스트필드 - textfield
    lazy var emailTxtField = UITextField().then {
        $0.backgroundColor = UIColor.white
        $0.placeholder = "이메일 주소"
        // 텍스트필드 상자 속성
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1).cgColor
        // MARK: - HERE To Solve
        $0.layer.frame.size.height = 47 /// 해결해야할 부분
        $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        // left padding
        $0.setPadding(left: 16, right: 0)
    }
    // 이메일주소 입력 안내 - label
    lazy var emailInfoLbl = UILabel().then {
        $0.text = "가입되지 않은 이메일입니다"
        $0.backgroundColor = UIColor.clear
        $0.textColor = UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 12)
        
    }
    // 비밀번호 - label
    lazy var pwLbl: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.white
        lbl.text = "비밀번호"
        lbl.textColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1)
        lbl.font = UIFont(name: "Pretendard-Bold", size: 14)
        
        // 정렬
        lbl.textAlignment = NSTextAlignment.left
        return lbl
    }()
    // 비밀번호 입력 안내 - label
    lazy var pwInfoLbl = UILabel().then {
        $0.text = "올바르지 않은 비밀번호입니다"
        $0.backgroundColor = UIColor.clear
        $0.textColor = UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 12)
        
    }
    // 비밀번호 입력 - textfield
    lazy var pwTxtField = UITextField().then {
        $0.backgroundColor = UIColor.clear
        $0.placeholder = "영문, 숫자, 특수문자를 사용한 8~16글자"
        // 텍스트필드 상자 크기
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1).cgColor
        $0.frame = CGRect(x: 0, y: 0, width: 327, height: 47)
        $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        
        // left padding
        $0.setPadding(left: 16, right: 0)
    }
    // 로그인 button
    lazy var loginBtn = UIButton().then {
        $0.layer.backgroundColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1).cgColor
        $0.setTitle("로그인", for: .normal)
        $0.layer.cornerRadius = 8
    }
    // 회원가입 label
    lazy var createAccountLbl = UILabel().then {
        $0.text = "아직 회원이 아니신가요?"
        $0.backgroundColor = UIColor.white
        $0.textColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
        
    }
    // 회원가입 button
    lazy var createAccountBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitleColor(UIColor.gsLightGray, for: .normal)
        $0.setTitle("회원가입", for: .normal)
        $0.setUnderline()
    }
    // 비밀번호 찾기 label
    lazy var forgetpwLbl = UILabel().then {
        $0.text = "비밀번호를 잃어버리셨나요?"
        $0.backgroundColor = UIColor.white
        $0.textColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
        
    }
    // 비밀번호 찾기 button
    lazy var forgetPwBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitleColor(UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1), for: .normal)
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setUnderline()
        // temp
        let attributedString = NSAttributedString(string: "비밀번호 찾기", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: UIColor.gsLightGray, NSAttributedString.Key.font: UIFont.pretendard(size: 14, family: .medium) ])
        $0.setAttributedTitle(attributedString, for: .normal)
    }
    // MARK: setUI
    func setUpView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.titleLbl) // 로그인
        self.view.addSubview(self.emailLbl) // 이메일
        self.view.addSubview(self.emailTxtField)
        self.view.addSubview(self.emailInfoLbl)
        self.view.addSubview(self.pwLbl) // 비밀번호
        self.view.addSubview(self.pwInfoLbl)
        self.view.addSubview(self.pwTxtField)
        self.view.addSubview(self.loginBtn) // 로그인 버튼
        self.view.addSubview(self.createAccountLbl) // 회원가입
        self.view.addSubview(self.createAccountBtn)
        self.view.addSubview(self.forgetpwLbl) // 비밀번호 찾기
        self.view.addSubview(self.forgetPwBtn)
    }
    
    // Constraints
    func setConstraints() {
        // 맨위 로그인 라벨
        self.titleLbl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
            $0.left.centerX.equalToSuperview()
            
        }
        // 이메일 주소 입력 - label
        self.emailLbl.snp.makeConstraints {
            $0.top.equalTo(titleLbl.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().offset(24)
        }
        
        // 이메일 입력 - textfield
        self.emailTxtField.snp.makeConstraints {
            $0.top.equalTo(emailLbl.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(47).constraint
        }
        // 아메일 입력 안내 - label
        self.emailInfoLbl.snp.makeConstraints {
            $0.top.equalTo(emailTxtField.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        // 비밀번호 입력 - label
        self.pwLbl.snp.makeConstraints {
            $0.top.equalTo(emailLbl.snp.bottom).offset(93)
            $0.leading.trailing.equalToSuperview().offset(24)
            $0.trailing.trailing.equalToSuperview().offset(24)
        }
        // 비밀번호 입력 - textfield
        self.pwTxtField.snp.makeConstraints {
            $0.top.equalTo(pwLbl.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(47).constraint
        }
        // 비밀번호 입력 안내 - label
        self.pwInfoLbl.snp.makeConstraints {
            $0.top.equalTo(pwTxtField.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.lessThanOrEqualToSuperview()
            
        }
        // 로그인 버튼 - button
        self.loginBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.equalTo(pwTxtField.snp.bottom).offset(52)
            $0.leading.trailing.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        // 회원가입 - label
        self.createAccountLbl.snp.makeConstraints {
            $0.top.equalTo(loginBtn.snp.bottom).offset(62)
            $0.leading.trailing.equalTo(loginBtn)
        }
        // 회원가입 - button
        self.createAccountBtn.snp.makeConstraints {
            $0.top.equalTo(loginBtn.snp.bottom).offset(62)
            $0.trailing.equalToSuperview().offset(-24)
        }
        // 비밀번호 찾기 - label
        self.forgetpwLbl.snp.makeConstraints {
            $0.top.equalTo(createAccountLbl.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(loginBtn)
        }
        // 비밀번호 찾기 - button
        self.forgetPwBtn.snp.makeConstraints {
            $0.top.equalTo(createAccountLbl.snp.bottom).offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    // Delegate
    func setDelegate() {
        pwTxtField.delegate = self
        emailTxtField.delegate = self
    }
    
    func setDefault() {
        pwInfoLbl.isHidden = true
        emailInfoLbl.isHidden = true
        pwTxtField.isSecureTextEntry = true
    }
    // MARK: - ViewDidLpad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setConstraints()
        self.setDelegate()
        self.setDefault() // infoLabel hidden 처리
        self.addActions()
//        bindData()
    }
    
    // MARK: - LifeCycle
    
    
    
    // MARK: - Selectors
    func addActions() {
        // 로그인 버튼
        loginBtn.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
        // 이메일 Textfield
        emailTxtField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        emailTxtField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        pwTxtField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        // 비밀번호 찾기
        forgetPwBtn.addTarget(self, action: #selector(goFindPassword), for: .touchUpInside)
        createAccountBtn.addTarget(self, action: #selector(createAccountBtnTapped), for: .touchUpInside)
    }
    
    // 텍스트 입력하는 동안
    @objc func textFieldDidChange(sender: UITextField) {
        // 색 변하기
        switch sender {
            
        case self.emailTxtField:
            
            guard let email = sender.text, !email.isEmpty else { return }
            
            if loginViewModel.isValidEmail(id: email) {
                sender.layer.borderColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1).cgColor
                emailStatus = true
                self.email = email
                self.emailInfoLbl.isHidden = true
            } else {
                // wrong
                DispatchQueue.main.async {
                    sender.layer.borderColor = UIColor.red.cgColor
                    self.emailInfoLbl.isHidden = false
                    self.emailInfoLbl.text = "올바른 형식의 이메일을 입력해주세요"
                }
                
            }
            
        case self.pwTxtField:
            guard let password = sender.text, !password.isEmpty else { return }
            
            if loginViewModel.isValidPassword(pwd: password) {
                sender.layer.borderColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1).cgColor
                self.pwInfoLbl.isHidden = true
                passwordStatus = true
                self.password = password
            } else {
                // wrong
                DispatchQueue.main.async {
                    sender.layer.borderColor = UIColor.red.cgColor
                    self.pwInfoLbl.isHidden = false
                    self.pwInfoLbl.text = "올바른 비밀번호를 입력해주세요"
                }
                
                
                
            }
        default:
            print("textfielddidchange")
            break
        }
        
        
    }
    
    @objc func goLogin(sender: UIButton) {
        // 로그인 버튼 클릭
        if emailStatus, passwordStatus {
            loginAction()
        } else {
            // 로그인 불가
            print("로그인 불가")
        }
        
    }
    
    @objc func goFindPassword(sender: UIButton) {
        // 비밀번호 찾으러 가기
        self.navigationController?.pushViewController(FindPasswordViewController(), animated: true)
        
    }
    // 키보드 내리기
    @objc func didEndOnExit(_ sender: UITextField) {
        if emailTxtField.isFirstResponder {
            pwTxtField.becomeFirstResponder()
        }
    }

    @objc func createAccountBtnTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }

    // MARK: - Helpers
    
    func loginAction() {
        LoginService.shared.login(email: self.emailTxtField.text!, passwd: self.pwTxtField.text!) { result in
            switch result
            {
            case.success(let userdata):
                print("로그인 통신 성공")
                
                if let data = userdata as? LoginDataClass {
                    
                    let accessToken = data.accessToken
                    let refreshToken = data.refreshToken
                    
                    // keychain 저장
                    KeyChain.shared.create(key: "accessToken", token: accessToken)
                    KeyChain.shared.create(key: "refreshToken", token: refreshToken)
                    print("Keychain 토큰 저장 성공")
                    
                }
                // 로그인 성공 -> 메인화면으로 가기
                self.navigationController?.pushViewController(MainTabViewController(), animated: true)
                
            case .requestErr(let location):
                // 로그인 실패
                if let location = location as? String{
                    DispatchQueue.main.async{
                        if location == "email" {
                            self.emailInfoLbl.isHidden = false
                            self.emailInfoLbl.text = "가입되지 않은 이메일입니다."
                        } else if location == "passwd" {
                            self.pwInfoLbl.isHidden = false
                            self.pwInfoLbl.text = "올바르지 않은 비밀번호입니다"
                        }
                    }
                    
                }
            default :
                print("ERROR")
            }
        }
        
    }
    
    func highlightTextField(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.cornerRadius = 8
    }
}

// MARK: Extension
// 파일 하나 만들어서 저장하기
extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}
// 나중에 파일 만들어서 추가하기
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func setPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
        
        if let left = left {
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.size.height))
            
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
        if let right = right {
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTxtField.resignFirstResponder()
        pwTxtField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailInfoLbl.isHidden = true
        pwInfoLbl.isHidden = true
        emailTxtField.layer.borderWidth = 0
        pwTxtField.layer.borderWidth = 0
        loginBtn.isEnabled = false // 로그인 버튼 터치 불가
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
