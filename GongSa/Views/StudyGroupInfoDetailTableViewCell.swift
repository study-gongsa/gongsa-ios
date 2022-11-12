//
//  StudyGroupInfoDetailTableViewCell.swift
//  GongSa
//
//  Created by taechan on 2022/11/12.
//

import UIKit
import SnapKit

final class StudyGroupInfoDetailTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "StudyGroupInfoDetailTableViewCell"
    
    private let userLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(size: 14, family: .medium)
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(size: 12, family: .medium)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(size: 12, family: .medium)
        label.textColor = .gsLightGray
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        return button
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
        let buttonStack = UIStackView(arrangedSubviews: [editButton, removeButton])
        
        addSubview(userLabel)
        addSubview(commentLabel)
        addSubview(dateLabel)
        addSubview(buttonStack)
        
        userLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(24)
            make.width.equalTo(100)
            make.height.equalTo(17)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(userLabel.snp.bottom).inset(-4)
            make.left.equalToSuperview().inset(24)
            make.width.equalToSuperview().inset(24)
            make.height.equalTo(30)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).inset(-8)
            make.left.equalToSuperview().inset(24)
            make.width.equalToSuperview().inset(24)
            make.height.equalTo(15)
        }
    }
    
    public func configure(comment: Comment) {
        self.userLabel.text = comment.user
        self.commentLabel.text = comment.comment
        self.dateLabel.text = comment.date
    }
    
    // MARK: - Selectors
}
