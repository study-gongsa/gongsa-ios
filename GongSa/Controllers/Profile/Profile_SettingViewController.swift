//
//  Profile_SettingViewController.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/11/11.
//


import UIKit
import SwiftUI
import SnapKit
import Then

// MARK: - Canvas
@available(iOS 13.0, *)
struct Profile_SettingViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = Profile_SettingViewController
    
    func makeUIViewController(context: Context) -> Profile_SettingViewController {
        return Profile_SettingViewController()
    }
    
    func updateUIViewController(_ uiViewController: Profile_SettingViewController, context: Context) {
    }
    
}

@available(iOS 13.0.0, *)
struct Profile_SettingTestViewProvider: PreviewProvider {
    static var previews: some View {
        Profile_SettingViewControllerRepresentable()
    }
}


// MARK: - Class MyPageVC

class Profile_SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.navigationController?.navigationBar.topItem?.title = "환경설정"
        self.navigationItem.title = "환경설정"
//        setNavigationBar()
        setView()
        setConstraints()
    }

    
    // MARK: - UI
    // 현재 프로필 이미지 ImageView
    lazy var profileImgView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .yellow
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40
        $0.layer.masksToBounds = true
    }
    // 이미지 변경 Button
    lazy var editImageBtn = UIButton().then {
        $0.setTitle("이미지 편집", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        // 폰트 수정하기

    }
    // 현재 닉네임 Label
    lazy var nicknameLbl = UILabel().then {
        
        $0.text = "현재 닉네임"
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
    }
    // 닉네임 Text Field
    lazy var nicknameTxtField = UITextField().then {
        
        $0.backgroundColor = .white
        $0.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1).cgColor
    }
    
    // 닉네임 안내 Label
    lazy var nicknameInfoLabel = UILabel().then {
        $0.text = "이미 사용되고 있는 닉네임입니다."
        $0.textColor = UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 12)
        // Line height: 14 pt
    }
    
    
    // 비밀번호 변경 Label
    lazy var nowPWLbl = UILabel().then {
        
        $0.text = "비밀번호 변경"
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
    }
    // 비밀번호 변경 TextField
    lazy var nowPWTxtField = UITextField().then {
        
        $0.backgroundColor = .white
        $0.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1).cgColor
    }
    
    // 비밀번호 변경 안내 Label
    lazy var nowPWInfoLabel = UILabel().then {
        $0.text = "잘못된 형식의 비밀번호입니다."
        $0.textColor = UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 12)
        // Line height: 14 pt
    }
    
    // 비밀번호 변경 확인 Label
    lazy var changePWLbl = UILabel().then {
        
        $0.text = "비밀번호 변경 확인"
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
    }
    // 비밀번호 변경 확인 Text Field
    lazy var changePWTxtField = UITextField().then {
        
        $0.backgroundColor = .white
        $0.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1).cgColor
    }
    
    // 비밀번호 변경 확인 안내 Label
    lazy var changePWInfoLabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.textColor = UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 12)
        // Line height: 14 pt
    }
    
    // 카테고리 Label
    lazy var categoryLbl = UILabel().then {
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
        // Line height: 17 pt
        // (identical to box height)
        $0.text = "카테고리 (복수선택 가능)"
    }
    
    // 카테고리 단추들
//    let categoryCollectionView: UICollectionView = {
//
//    }()
    
    
    // 확인 Button
    lazy var okButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
    }
    
    
    // MARK: - Set View
    func setView(){
        view.addSubview(self.profileImgView)
        view.addSubview(self.editImageBtn)
        view.addSubview(self.nicknameLbl)
        view.addSubview(self.nicknameTxtField)
        view.addSubview(self.nicknameInfoLabel)
        view.addSubview(self.nowPWLbl)
        view.addSubview(self.nowPWTxtField)
        view.addSubview(self.nowPWInfoLabel)
        view.addSubview(self.changePWLbl)
        view.addSubview(self.changePWTxtField)
        view.addSubview(self.changePWInfoLabel)
        view.addSubview(self.categoryLbl)
        
    } // end of View
    
    
    
    // MARK: - Set Constraints
    func setConstraints() {
        
        // 현재 프로필 이미지 Image View
        self.profileImgView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(84)
            $0.height.equalTo(84)
        }
        // 이미지 변경 Button
        self.editImageBtn.snp.makeConstraints {
            $0.top.equalTo(self.profileImgView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            
        }
        // 현재 닉네임 Label
        self.nicknameLbl.snp.makeConstraints {
            $0.top.equalTo(self.editImageBtn.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(24)
        }
        // 닉네임 TextField
        self.nicknameTxtField.snp.makeConstraints {
            $0.top.equalTo(self.nicknameLbl.snp.bottom).offset(8)
            $0.leading.equalTo(nicknameLbl)
            $0.width.equalTo(327)
            $0.height.equalTo(47)
            
        }
        // 닉네임 안내 Label
        self.nicknameInfoLabel.snp.makeConstraints {
            $0.top.equalTo(self.nicknameTxtField.snp.bottom).offset(4)
            $0.leading.equalTo(self.nicknameTxtField)
        }
        
        // 비밀번호 변경 Label
        self.nowPWLbl.snp.makeConstraints {
            $0.top.equalTo(self.nicknameTxtField.snp.bottom).offset(38)
            $0.leading.equalTo(nicknameLbl)
        }
        // 비밀번호 변경 Text Field
        self.nowPWTxtField.snp.makeConstraints {
            $0.top.equalTo(self.nowPWLbl.snp.bottom).offset(8)
            $0.leading.equalTo(nowPWLbl)
            $0.width.equalTo(327)
            $0.height.equalTo(47)
        }
        
        // 비밀번호 변경 안내 Label
        self.nowPWInfoLabel.snp.makeConstraints {
            $0.top.equalTo(self.nowPWTxtField.snp.bottom).offset(4)
            $0.leading.equalTo(self.nowPWLbl)
        }
        
        // 비밀번호 변경 확인 Label
        self.changePWLbl.snp.makeConstraints {
            $0.top.equalTo(self.nowPWTxtField.snp.bottom).offset(38)
            $0.leading.equalTo(self.nicknameLbl)
        }
        
        // 비밀번호 변경 확인 Text Field
        self.changePWTxtField.snp.makeConstraints {
            $0.top.equalTo(self.changePWLbl.snp.bottom).offset(8)
            $0.leading.equalTo(changePWLbl)
            $0.width.equalTo(327)
            $0.height.equalTo(47)
        }
        
        // 비밀번호 변경 일치 안내 Label
        self.changePWInfoLabel.snp.makeConstraints {
            $0.top.equalTo(self.changePWTxtField.snp.bottom).offset(4)
            $0.leading.equalTo(self.changePWLbl)
        }
        
        
        // 카테고리 안내
        self.categoryLbl.snp.makeConstraints {
            $0.top.equalTo(self.changePWTxtField.snp.bottom).offset(38)
            $0.leading.equalTo(nicknameLbl)
        }
        
        
        
    } // end of Constraints
    
    
    
    
    
}
private extension Profile_SettingViewController {
    @available(iOS 13.0, *)
    func setNavigationBar(){
        configureNavigationTitle()
//        configureNavigationButton()
    }
    
    func configureNavigationTitle(){
        self.title = "환경설정"
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Copperplate", size: 21) ?? UIFont()]
    }
    
    @available(iOS 13.0, *)
    func configureNavigationButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: nil)
    }
}
