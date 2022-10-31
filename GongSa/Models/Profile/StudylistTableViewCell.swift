//
//  StudylistTableViewCell.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/10/28.
//


import Foundation
import UIKit
import Then
import SnapKit

class StudylistTableViewCell: UITableViewCell {
    // cell identifier
    static let identifier = "StudylistCell"
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    // MARK: Cell UI
    lazy var groupnameLbl = UILabel().then {
        $0.text = "공시생 스터디 그룹 내 랭킹 정보"
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
    }
    
    
    lazy var rank1Lbl = UILabel().then {
        $0.text = "1위: 홍길동"
        $0.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
    }
    
    lazy var rank2Lbl = UILabel().then {
        $0.text = "2위: 김아메리카노"
        $0.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
    }
    lazy var rank3Lbl = UILabel().then {
        $0.text = "3위: 박카페라떼"
        $0.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
    }
    lazy var rank4Lbl = UILabel().then {
        $0.text = "4위: 김영희"
        $0.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
    }
    
    // 랭킹 담을 stack view
    lazy var rankStckView = UIStackView().then {
        $0.axis = .vertical // 방향 세로로
        $0.distribution = .equalSpacing
        $0.spacing = 4 // 요소끼리 간격
        $0.alignment = .leading // 왼쪽에서 시작
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: Set View
    func setView() {
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.groupnameLbl)
        self.containerView.addSubview(self.rankStckView)
        self.rankStckView.addArrangedSubview(self.rank1Lbl)
        self.rankStckView.addArrangedSubview(self.rank2Lbl)
        self.rankStckView.addArrangedSubview(self.rank3Lbl)
        self.rankStckView.addArrangedSubview(self.rank4Lbl)
//        [rank1Lbl, rank2Lbl, rank3Lbl, rank4Lbl].map {
//            self.rankStckView.addArrangedSubview($0) // 순서에 따라 stackview에 추가
//            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1.0).isActive = true // 라벨의 h와 w가 1:1 비율 가짐
//        }
        
        
    }
    
    // MARK: Set Constraints
    func setConstraints() {
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.groupnameLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview()
        }
        
        self.rankStckView.snp.makeConstraints {
            $0.top.equalTo(groupnameLbl.snp.bottom).offset(12)
            $0.leading.equalTo(groupnameLbl)
        }
        
        self.rank1Lbl.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        self.rank2Lbl.snp.makeConstraints {
            $0.top.equalTo(rank1Lbl.snp.bottom).offset(4)
            $0.leading.equalTo(rank1Lbl)
        }
        self.rank3Lbl.snp.makeConstraints {
            $0.top.equalTo(rank2Lbl.snp.bottom).offset(4)
            $0.leading.equalTo(rank1Lbl)
        }
        self.rank4Lbl.snp.makeConstraints {
            $0.top.equalTo(rank3Lbl.snp.bottom).offset(4)
            $0.leading.equalTo(rank1Lbl)
        }
    } // end of the Constraints
    
    
}
