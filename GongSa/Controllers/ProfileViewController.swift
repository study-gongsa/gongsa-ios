//
//  ProfileViewController.swift
//  GongSa
//
//  Created by taechan on 2022/07/31.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    
    
    
    // MARK: - UI Layout
    
    // 프로필 사진 ImageView
    lazy var profileImgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "testImg")
        img.backgroundColor = .blue
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 40
        img.layer.masksToBounds = true
        return img
        
    }()
    
    // 이름 Label
    lazy var nameLbl = UILabel().then {
        $0.text = "홍길동"
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 20)
    }
    
    // 누적 공부 시간 Label
    lazy var timeLbl = UILabel().then {
        $0.text = "12h 30m"
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
    }
    
    
    lazy var studyingLbl = UILabel().then {
        $0.text = "스터디 중"
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
    }
    // 레벨 Label
    lazy var levelLbl = UILabel().then {
        $0.text = "레벨 7"
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
    }
    // 상위 % Label
    lazy var rankLbl = UILabel().then {
        $0.text = "상위 1%"
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
    }
    // Q&A 버튼
    lazy var qaBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 49, height: 28)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.layer.cornerRadius = 15
        $0.layer.borderColor = UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1).cgColor
        $0.layer.borderWidth = 1
        $0.setTitle(" Q&A ", for: .normal)
        
    }
    // 톱니바퀴 버튼
    lazy var settingBtn = UIButton().then {
        $0.backgroundColor = .white
        if #available(iOS 13.0, *) {
            $0.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        $0.tintColor = .darkGray
        $0.frame = CGRect(x: 0, y: 0, width: 17.2, height: 18.33)
    }
    // 하단 스터디목록 TableView
    var studylistTableView = UITableView().then {
        
        $0.register(StudylistTableViewCell.self, forCellReuseIdentifier: StudylistTableViewCell.identifier)
    }
    
    // MARK: *** Set View ***
    func setUIView() {
        self.view.addSubview(self.profileImgView)
        self.view.addSubview(self.nameLbl)
        self.view.addSubview(self.levelLbl)
        self.view.addSubview(self.rankLbl)
        self.view.addSubview(self.studyingLbl)
        self.view.addSubview(self.timeLbl)
        self.view.addSubview(self.qaBtn)
        self.view.addSubview(self.settingBtn)
        self.view.addSubview(self.studylistTableView)
    }
    
    
    // MARK: *** UI Constraints ***
    func setConstraints() {
        // 맨위 프로필 이미지 ImgView
        self.profileImgView.snp.makeConstraints {
            //            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.top.equalToSuperview().offset(68)
            $0.size.height.width.equalTo(84)
            $0.left.equalToSuperview().offset(24)
            
        }
        // 이름 Label
        self.nameLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(69)
            $0.left.equalTo(profileImgView.snp.right).offset(20)
        }
        
        // 누적공부시간 Label
        self.timeLbl.snp.makeConstraints {
            $0.top.equalTo(nameLbl.snp.bottom).offset(20)
            $0.leading.equalTo(profileImgView.snp.trailing).offset(20)
        }
        // 공부중 Label
        self.studyingLbl.snp.makeConstraints {
            $0.top.equalTo(timeLbl)
            $0.leading.equalTo(timeLbl.snp.trailing).offset(7)
        }
        // 레벨 Label
        self.levelLbl.snp.makeConstraints {
            $0.top.equalTo(timeLbl.snp.bottom).offset(4)
            $0.leading.equalTo(profileImgView.snp.trailing).offset(20)
        }
        
        self.rankLbl.snp.makeConstraints {
            $0.top.equalTo(levelLbl)
            $0.leading.equalTo(levelLbl.snp.trailing).offset(7)
        }
        
        self.qaBtn.snp.makeConstraints {
            $0.top.equalTo(settingBtn.snp.bottom).offset(33.83)
//            $0.leading.equalTo(rankLbl.snp.trailing).offset(84)
            $0.trailing.equalToSuperview().offset(-24)
            $0.width.equalTo(49)
            $0.height.equalTo(28)
        }
        // 톱니바퀴 Button
        self.settingBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(71.83)
            $0.trailing.equalToSuperview().offset(-25.4)
            $0.width.equalTo(17.2)
            $0.height.equalTo(18.33)
        }
        // 스터디 그룹 리스트 TableView
        self.studylistTableView.snp.makeConstraints {
            
            $0.top.equalTo(profileImgView.snp.bottom).offset(60)
            $0.trailing.leading.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
        
        
    } // end of the Contstraints
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIView()
        configure()
        setConstraints()
        
    }
    
    // MARK: Configure
    func configure(){
        studylistTableView.delegate = self
        studylistTableView.dataSource = self
        studylistTableView.rowHeight = 151
    }
    
    // MARK: - Network
    // 유저 정보 가져오기
    func bringProfile() {
        UserInfoService.shared.getUserInfo() { result in
            switch result
            {
            case .success(let userinfo):
                print("Mypage 통신 성공")
                // 유저 정보 조회 성공
                
                print(userinfo)
                if let data = userinfo as? UserDataClass {
                    print("Mypage 정보 로딩 성공")
                    // 닉네임
                    self.nameLbl.text = data.nickname
                    // 누적 공부 시간
                    self.timeLbl.text = data.totalStudyTime
                    self.levelLbl.text = String(data.level)
                    self.rankLbl.text = String(data.percentage)
                    // 이미지 처리
                    // data.imgPath
                }
                
            case .requestErr(let msg):
                // 로그인 실패
                if let msg = msg as? String{
                    
                    print("마이페이지 통신 에러", "\(msg)")
                    // 나중에 다시 팝업 창 뜨게 하기
                }
            default :
                print("DEFAULT ERROR")
            }
        }
    }
    // 유저 가입한 스터디 그룹 가져오기
    func getStudyGroups() {
        
        
        
    }
    
    // MARK: - Selectors
    
    // 톱니바퀴 버튼
    
    
    // MARK: - Helpers
} //  end of the class



// MARK: - TableView Delegate & DataSource
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StudylistTableViewCell.identifier, for: indexPath) as! StudylistTableViewCell
        
        return cell
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}
