//
//  ProfileViewController.swift
//  GongSa
//
//  Created by taechan on 2022/07/31.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    var groups : [GroupRankList] = []
    
    
    
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
        // 버튼 누르기
        $0.addTarget(self, action: #selector(goQnA), for: .touchUpInside)
        
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
        // 버튼 누르기
        $0.addTarget(self, action: #selector(goSetting), for: .touchUpInside)
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
        bringProfile()
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
                
                if let data = userinfo as? UserDataClass {
                    print("Mypage 정보 로딩 성공")
                    // 닉네임
                    self.nameLbl.text = data.nickname
                    // 누적 공부 시간
                    self.timeLbl.text = data.totalStudyTime
                    // 레벨 - LV.4
                    self.levelLbl.text = "LV." + String(data.level)
                    // 랭크 - 상위 1%
                    self.rankLbl.text = "상위 "+String(data.percentage) + "%"
                    
                    // 이미지 처리
                    let img = data.imgPath
                    let url = URL(string: "http://3.36.170.161:8080/api/image/\(img)")
                    self.profileImgView.imageDownload(url: url!)
//                    self.profileImgView.getImageRequest(url: url!)
                    
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
        
        StudyGroupListsService.shared.getStudyGroupLists() { result in
            switch result
            {
            case .success(let studydata):
                print("스터디 그룹 가져오기 통신 성공")
                if let data = studydata as? StudyGroupDataClass {
                    print("스터디그룹 리스트 데이터 가져오기 성공")
                    self.groups = data.groupRankList
                    print(self.groups.count)
                    self.studylistTableView.reloadData()
                }
            case .requestErr(let msg):
                // 로그인 실패
                if let msg = msg as? String{
                    
                    print("마이페이지 통신 에러", "\(msg)")
                    // 나중에 다시 팝업 창 뜨게 하기
                }
            
            case .loginErr(let msg):
                if let msg  = msg as? String {
                    print(msg, "로그인 에러")
                    
                }
            case .authErr(let msg):
                if let msg = msg as? String {
                    print(msg, "권한 에러")
                }
            default :
                print("DEFAULT ERROR 이거야")
            }
        }
        
        
        
    }
    
    // MARK: - Selectors
    
    @objc func goSetting(sender: UIButton) {
        print("마이페이지 Setting으로 가자")
        // 먼저 다음 화면으로 가기 loading View
        self.navigationController?.pushViewController(Profile_SettingViewController(), animated: true)
        
    }
    
    @objc func goQnA(sender: UIButton) {
        print("마이페이지 질문보기로 가자")
        // 먼저 다음 화면으로 가기 loading View
        self.navigationController?.pushViewController(Profile_QAViewController(), animated: true)
        
    }
    
    
    
    // MARK: - Helpers
} //  end of the class



// MARK: - TableView Delegate & DataSource
extension ProfileViewController: UITableViewDelegate {
    // Cell 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = groups.count
        
        return rows
    }
    // Cell 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: StudylistTableViewCell.identifier, for: indexPath) as! StudylistTableViewCell
        
        // Row - 주어진 행에 맞춰 데이터 읽기
        let groupRow = self.groups[indexPath.row]
//        let member = groupRow.members[indexPath.row]
        
        
        // Cell 내용
        // Group 이름
        cell.groupnameLbl.text = self.groups[indexPath.row].name
        // Group - Member 이름
        let memberCount = self.groups[indexPath.row].members.count
        let mem = self.groups[indexPath.row].members

        switch memberCount {
        case 1:
            cell.rank1Lbl.text = "1위: " + mem[0].nickname
            // 없는 애들 숨기기
            cell.rank2Lbl.isHidden = true
            cell.rank3Lbl.isHidden = true
            cell.rank4Lbl.isHidden = true
            //
        case 2:
            cell.rank1Lbl.text = "1위: " + mem[0].nickname
            cell.rank2Lbl.text = "2위: " + mem[1].nickname
            // 없는 애들 숨기기
            cell.rank3Lbl.isHidden = true
            cell.rank4Lbl.isHidden = true
            //
        case 3:
            cell.rank1Lbl.text = "1위: " + mem[0].nickname
            cell.rank2Lbl.text = "2위: " + mem[1].nickname
            cell.rank3Lbl.text = "3위: " + mem[2].nickname
            // 없는 애들 숨기기
            cell.rank4Lbl.isHidden = true
        case 4..<10:
            cell.rank1Lbl.text = "1위: " + mem[0].nickname
            cell.rank2Lbl.text = "2위: " + mem[1].nickname
            cell.rank3Lbl.text = "3위: " + mem[2].nickname
            cell.rank4Lbl.text = "4위: " + mem[3].nickname
            
        default:
            print("Cell 가지고 오는데 ERROR")
        }
        // 순위에 내 이름 있으면 하이라이트 하기
        if mem[0].nickname == self.nameLbl.text {
            cell.rank1Lbl.textColor =  UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
            cell.rank1Lbl.font = UIFont(name: "Pretendard-Bold", size: 14)
        } else if mem[1].nickname == self.nameLbl.text {
            cell.rank2Lbl.textColor =  UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
            cell.rank2Lbl.font = UIFont(name: "Pretendard-Bold", size: 14)
        } else if mem[2].nickname == self.nameLbl.text {
            cell.rank3Lbl.textColor =  UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
            cell.rank3Lbl.font = UIFont(name: "Pretendard-Bold", size: 14)
        } else if mem[3].nickname == self.nameLbl.text {
            cell.rank4Lbl.textColor =  UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
            cell.rank4Lbl.font = UIFont(name: "Pretendard-Bold", size: 14)
        } else {}
        
        return cell
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}
