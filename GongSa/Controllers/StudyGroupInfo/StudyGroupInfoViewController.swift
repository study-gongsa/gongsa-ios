//
//  StudyGroupInfo.swift
//  GongSa
//
//  Created by taechan on 2022/10/31.
//

import UIKit
import SnapKit

final class StudyGroupInfoViewController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel.customLabel(with: "스터디 정보", color: .black, fontSize: 24, fontFamily: .bold)
        return label
    }()
    
    private let studyGroupName: UILabel = {
        let label = UILabel.customLabel(with: "스터디 명", color: .black, fontSize: 16, fontFamily: .medium)
        return label
    }()
    
    private let term: UILabel = {
        let label = UILabel.customLabel(with: "기간", color: .black, fontSize: 16, fontFamily: .medium)
        return label
    }()
    
    private let isCam: UILabel = {
        let label = UILabel.customLabel(with: "캠 여부", color: .black, fontSize: 16, fontFamily: .medium)
        return label
    }()
    
    private let penalty: UILabel = {
        let label = UILabel.customLabel(with: "벌점", color: .black, fontSize: 16, fontFamily: .medium)
        return label
    }()
    
    private let minimumTime: UILabel = {
        let label = UILabel.customLabel(with: "최소 시간", color: .black, fontSize: 16, fontFamily: .medium)
        return label
    }()
    
    private let category: UILabel = {
        let label = UILabel.customLabel(with: "카테고리", color: .black, fontSize: 16, fontFamily: .medium)
        return label
    }()
    
    private lazy var qnaButton: UIButton = {
        let button = UIButton.main(withTitle: "Q&A")
        button.addTarget(self, action: #selector(qnaButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var leaveButton: UIButton = {
        let button = UIButton.underLined(withText: "탈퇴하기", withColor: .gsDarkGray)
        return button
    }()
    
   
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        addSubViews()
        configureUI()
    }
    
    // MARK: - Helpers
    private func addSubViews() {
    }
    private func configureUI() {
        
        let subtitleStackViews = UIStackView(arrangedSubviews: [studyGroupName, term,
                                                            isCam, penalty,
                                                            minimumTime, category])
        
        view.addSubview(titleLabel)
        view.addSubview(qnaButton)
        view.addSubview(leaveButton)
        view.addSubview(subtitleStackViews)
        
        /// title
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(84)
            make.left.equalToSuperview().inset(24)
            make.width.equalTo(110)
            make.height.equalTo(29)
        }
        
        /// Q&A button
        qnaButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(84)
            make.right.equalToSuperview().inset(24)
            make.width.equalTo(49)
            make.height.equalTo(28)
        }

        /// leave button
        leaveButton.snp.makeConstraints { make in
            make.top.equalTo(qnaButton.snp.bottom).inset(-23)
            make.right.equalToSuperview().inset(24)
            make.width.equalTo(42)
            make.height.equalTo(14)
        }

        /// sub-titles
        subtitleStackViews.axis = .vertical

        subtitleStackViews.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-20)
            make.left.equalToSuperview().inset(24)
            make.width.equalTo(183)
            make.height.equalTo(184)
        }

        studyGroupName.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        term.snp.makeConstraints { make in
            make.top.equalTo(studyGroupName.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        isCam.snp.makeConstraints { make in
            make.top.equalTo(term.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        penalty.snp.makeConstraints { make in
            make.top.equalTo(isCam.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        minimumTime.snp.makeConstraints { make in
            make.top.equalTo(penalty.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        category.snp.makeConstraints { make in
            make.top.equalTo(minimumTime.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        /// category collection view
        
        /// user collection view
    }
    
    
    // MARK: - Selectors
    @objc private func qnaButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(QnaViewController(), animated: true)
    }
}
