//
//  FindPasswordViewController.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/09/02.
//

import Foundation
import SnapKit
import SwiftUI
import Then


class FindPasswordViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "비밀번호 찾기"
//        self.navigationController?.title = "비밀번호 찾기"
//        self.navigationController?.navigationItem.title = "hi"
        self.setUpView()
        self.setConstaints()
        self.setDefault()
    }
    
    // 첫 기본 설정
    func setDefault() {
        self.okEmailBtn.isEnabled = false
        self.emailTxtField.addTarget(self,
                    action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Layout
    // 이메일 입력 안내 - label
    lazy var writeEmailLbl = UILabel().then {
        $0.backgroundColor = UIColor.white
        $0.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.text = "회원가입 시 등록한 이메일을 입력하세요."
    }
    
    // 이메일 - label
    lazy var emailLbl = UILabel().then {
        $0.backgroundColor = UIColor.white
        $0.textColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
        $0.text = "이메일 주소"
    }
    
    // 이메일 텍스트필드 - textfield
    lazy var emailTxtField = UITextField().then {
        $0.backgroundColor = UIColor.white
        $0.placeholder = "이메일 주소"
        // 텍스트필드 상자 속성
        
        $0.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1).cgColor
        $0.layer.frame.size.height = 47
        // MARK: - HERE To Solve
//        $0.layer.frame.size.height = 47 /// 해결해야할 부분
        $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        // left padding
        $0.setPadding(left: 16, right: 0)
    }
    
    lazy var emailDescriptionLbl = UILabel().then {
        $0.backgroundColor = UIColor.white
        $0.text = "이메일 입력 안내문"
        
    }
    
    
    
    lazy var okEmailBtn = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 327, height: 52)
        $0.backgroundColor = .white
        $0.layer.backgroundColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1).cgColor
        $0.layer.cornerRadius = 8
        $0.setTitle("확인", for: .normal)
        $0.addTarget(self, action: #selector(goFindPassword), for: .touchUpInside)
    }
    
    func setUpView() {
        self.view.addSubview(self.writeEmailLbl) // 로그인
        self.view.addSubview(self.emailLbl)
        self.view.addSubview(self.emailTxtField)
        self.view.addSubview(self.okEmailBtn)
    }
    
    func setConstaints() {
        // 로그인 버튼 - button
        /*
        self.loginBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.equalTo(pwTxtField.snp.bottom).offset(58)
            $0.leading.trailing.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            
        }
         */
        self.writeEmailLbl.snp.makeConstraints {
//            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(72)
            $0.top.equalToSuperview().offset(72)
            $0.leading.trailing.equalToSuperview().offset(24)
        }
        self.emailLbl.snp.makeConstraints {
            $0.top.equalTo(writeEmailLbl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().offset(24)
        }
        
        self.emailTxtField.snp.makeConstraints {
            $0.top.equalTo(emailLbl.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        self.okEmailBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.equalTo(emailTxtField.snp.bottom).offset(58)
            $0.leading.trailing.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.height.equalTo(52)
        }
//        // 로그인 버튼 - button
//        self.loginBtn.snp.makeConstraints {
//            $0.center.equalToSuperview()
//            $0.top.equalTo(pwTxtField.snp.bottom).offset(58)
//            $0.leading.trailing.equalToSuperview().offset(24)
//            $0.trailing.equalToSuperview().offset(-24)
//
//        }
        
    }
    
    // MARK: - Event
    
    @objc func goFindPassword(sender: UIButton) {
        print("비밀번호 찾기로 가자")
        // 먼저 다음 화면으로 가기 loading View
        self.navigationController?.pushViewController(FindPasswordLoadingView(), animated: true)
        
        // 비밀번호 찾기 API
        findPassword()
        
    }
    
    // MARK: - Network
    func findPassword() {
        // 비밀번호 찾기
        PasswordService.shared.findPassword(email: self.emailTxtField.text!) { result in
            switch result
            {
            case.success(_):
                // 임시 비밀번호 이메일 보냄
                print(" 비밀번호 찾기 이메일 보내기 성공")
                // 성공했으니깐 로그인화면으로
                self.navigationController?.popToRootViewController(animated: true)
                
                
            case .requestErr(let msg):
                print(" 비밀번호 찾기 error")
                //실패했으니깐 다시 이메일 입력 화면으로
                self.navigationController?.popViewController(animated: true)
                
                if let msg = msg as? String {
                    DispatchQueue.main.async {
                        self.emailDescriptionLbl.text = "\(msg)"
                    }
                }
                
            default:
                print("error")
            }
            
        }
        
    }
    
    @objc func textFieldDidChange(sender: UITextField) {
        if sender.text?.isEmpty == true {
            self.okEmailBtn.isEnabled = false
        } else {
            self.okEmailBtn.isEnabled = true
        }
    }
    
    
    
}
