//
//  Studyroom_StudyingMembersCollectionViewCell.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/11/03.
//


import Foundation
import UIKit
import Then
import SnapKit

class Studyroom_StudyingMembersCollectionViewCell: UICollectionViewCell {
    
    // Cell Identifier
    static let identifier = "Studyroom_StudyingMembersCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    lazy var containerView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1).cgColor
//        $0.layer.borderColor = UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
    }
    
    lazy var containerStackView = UIStackView().then {
        $0.backgroundColor = .white
        $0.axis = .vertical // 방향 세로로
        $0.distribution = .fillProportionally
        $0.alignment = .top // 왼쪽에서 시작
    }
    
    // 카메라 넣는 View
    lazy var memberCamContentView = UIView().then {
        $0.backgroundColor = .yellow
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner]
        $0.layer.maskedCorners = [.layerMinXMinYCorner]
    }
    
    // 멤버 카메라 Image View
    lazy var memberCamImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        
    }
    
    // 시간 담는 View
    lazy var memberTimeContentView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
        $0.layer.cornerRadius = 10
    }
    
    // 시간 Label
    lazy var memTimeLbl = UILabel().then {
        
        $0.text = "12시간 30분"
        $0.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)


    }
    
    func setView(){
        self.contentView.addSubview(self.containerView)
        // stack view
//        self.containerView.addSubview(self.containerStackView)
        self.containerView.addSubview(self.memberCamContentView)
        self.memberCamContentView.addSubview(self.memberCamImageView)
        self.containerView.addSubview(self.memberTimeContentView)
        self.memberTimeContentView.addSubview(self.memTimeLbl)
        
//        self.containerView.addSubview(self.memberCamContentView)
        
//        self.containerView.addSubview(self.memTimeLbl)
//        self.memberTimeContentView.addSubview(self.memTimeLbl)
    }
    
    func setConstraints(){
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        self.containerStackView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
        // 멤버 카메라 넣는 View
        self.memberCamContentView.snp.makeConstraints {
//            $0.top.leading.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview().offset(-29)
            
            $0.leading.top.trailing.equalTo(0)
            $0.bottom.equalTo(-29)
        }
        // 시간 넣는 View
        self.memberTimeContentView.snp.makeConstraints {
            $0.top.equalTo(memberCamContentView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        // 멤버 카메라 Image View
        self.memberCamImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        // 멤버 누적 공부 시간 Label
        self.memTimeLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.center.equalToSuperview()
            
        }
        
        
//
//        self.memTimeLbl.snp.makeConstraints {
////            $0.top.equalTo(memberCamContentView.snp.bottom).offset(6)
//            $0.centerY.equalTo(memberCamImageView.center.y)
//
////            $0.leading.bottom.trailing.equalTo(0)
//            $0.top.equalTo(memberCamContentView.snp.bottom).offset(6)
//        }
    }
    
}
