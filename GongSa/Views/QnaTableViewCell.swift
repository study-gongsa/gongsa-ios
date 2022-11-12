//
//  QnaTableViewCell.swift
//  GongSa
//
//  Created by taechan on 2022/10/31.
//

import UIKit
import SnapKit

final class QnaTableViewCell: UITableViewCell {
    static let identifier = "QnaTableViewCell"
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel.customLabel(with: "temp title", color: .gsBlack, fontSize: 14, fontFamily: .medium)
        return label
    }()
    
    private let contentsLabel: UILabel = {
        let label = UILabel.customLabel(with: "temp contents", color: .gsBlack, fontSize: 12, fontFamily: .medium)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel.customLabel(with: "2022.10.31", color: .gsBlack, fontSize: 12, fontFamily: .medium)
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel.customLabel(with: "질문", color: .gsBlack, fontSize: 12, fontFamily: .medium)
        return label
    }()
    
    private let answeredLabel: UILabel = {
        let label = UILabel.customLabel(with: "응답 대기중", color: .gsBlack, fontSize: 12, fontFamily: .bold)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Search Group table view cell - init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        /// add subviews
        let stackView = UIStackView(arrangedSubviews: [dateLabel, questionLabel, answeredLabel])
        addSubview(titleLabel)
        addSubview(contentsLabel)
        addSubview(stackView)
        
        /// title label
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
        }
        
        /// contents label
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(40)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
        }
        
        /// Stack - date label, question label, answered label
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentsLabel.snp.bottom).inset(-8)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(24)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(dateLabel.snp.right).inset(-4)
            make.bottom.equalToSuperview()
        }
        answeredLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(questionLabel.snp.right).inset(12)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    public func configure(qna: Qna) {
        self.titleLabel.text = qna.title
        self.contentsLabel.text = qna.contents
        self.dateLabel.text = qna.date
        self.answeredLabel.text = qna.isAnswered ? "응답 완료" : "응답 대기 중"
    }
    
    // MARK: - Selectors
}
