//
//  StudyRoomViewController.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/10/16.
//

import UIKit
import SwiftUI
import SnapKit
import Then

class StudyRoomViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.navigationItem.title = "비밀번호 찾기"
    
        self.configure()
        self.setUpView()
        self.setConstaints()
    
    }
    
    func configure () {
        self.memberCollecionView.delegate = self
        self.memberCollecionView.dataSource = self
        self.memberCollecionView.register(Studyroom_StudyingMembersCollectionViewCell.self, forCellWithReuseIdentifier: Studyroom_StudyingMembersCollectionViewCell.identifier)
    }
    
    // MARK: - Event

    
    
    
    
    
    // MARK: - UI
    // 이미지뷰 담을 뷰
    lazy var myCameraContentView = UIView().then {
        $0.backgroundColor = .white
    }
    
    // 프로필 이미지 뷰
    lazy var myCameraView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "testImg")
        img.backgroundColor = .blue
        img.contentMode = .scaleAspectFill
        return img
        
    }()
    
    var memberCollecionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
//    var memberCollecionView = UICollectionView().then {
//        let flowLayout = UICollectionViewFlowLayout.self
//        $0.register(Studyroom_StudyingMembersCollectionViewCell.self, forCellWithReuseIdentifier: Studyroom_StudyingMembersCollectionViewCell.identifier)
//    }
    
    
    // MARK: - Set View
    func setUpView() {
        self.view.addSubview(self.myCameraContentView)
        self.myCameraContentView.addSubview(self.myCameraView)
        self.view.addSubview(self.memberCollecionView) // 로그인
        
    }
    
    //MARK: - UI Constraints
    
    func setConstaints() {
        // ImageView 담을 View
        self.myCameraContentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(375)
            $0.height.equalTo(335)
            
        }
        // 상단 내 화면 ImageView
        self.myCameraView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//         아래 하단 멤버 Collection View
        self.memberCollecionView.snp.makeConstraints {
            $0.top.equalTo(myCameraContentView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
            
//            $0.top.equalTo(profileImgView.snp.bottom).offset(60)
//            $0.trailing.leading.equalToSuperview().inset(24)
//            $0.bottom.equalToSuperview()

        }

        
        
        
    }
}

// MARK: CollectionView Extension
extension StudyRoomViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Studyroom_StudyingMembersCollectionViewCell.identifier, for: indexPath)
        cell.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing : CGFloat = 12
        
        let myWidth : CGFloat = (collectionView.bounds.width - itemSpacing * 2) / 3
        
        
        return CGSize(width: myWidth, height: myWidth)
    }
}


