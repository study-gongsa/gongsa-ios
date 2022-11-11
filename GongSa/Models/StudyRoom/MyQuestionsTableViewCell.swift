//
//  MyQuestionsTableViewCell.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/11/11.
//

import Foundation
import UIKit
import Then
import SnapKit

class MyQuestionsTableViewCell: UITableViewCell {
    // cell identifier
    static let identifier = "MyQuestionCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setView()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: - Cell Layout
    
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
    }
    // 제목 Label
    lazy var titleLbl = UILabel().then {
        $0.text = "제목"
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 1
        

    }
    // 내용 Label
    lazy var contentsLbl = UILabel().then {
        $0.text = "이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다."
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 12)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byTruncatingTail
        $0.adjustsFontSizeToFitWidth = false
    }
    // 날짜 Label
    lazy var dateLbl = UILabel().then {
        $0.text = "11월 01일 질문"
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 12)
    }
    // 응답 상태 Label
    lazy var answerStateLbl = UILabel().then {
        $0.backgroundColor = .white
        $0.textColor = UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 12)
        $0.text = "응답 완료"
    }
    
    
    // MARK: - View
    func setView() {
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.titleLbl)
        self.containerView.addSubview(self.contentsLbl)
        self.containerView.addSubview(self.dateLbl)
        self.containerView.addSubview(self.answerStateLbl)
    }
    
    // MARK: - Constriants
    func setConstraints() {
        
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.titleLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().offset(24)
            
            
        }
        
        self.contentsLbl.snp.makeConstraints {
            $0.top.equalTo(self.titleLbl.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(self.titleLbl)
            
        }
        
        self.dateLbl.snp.makeConstraints {
            $0.top.equalTo(self.contentsLbl.snp.bottom).offset(8)
            $0.leading.equalTo(self.titleLbl)
            $0.bottom.equalToSuperview().offset(-24)
        }
        
        self.answerStateLbl.snp.makeConstraints {
            $0.top.equalTo(self.dateLbl)
            $0.leading.equalTo(self.dateLbl.snp.trailing).offset(12)
        }
    }
    
    
    
}
