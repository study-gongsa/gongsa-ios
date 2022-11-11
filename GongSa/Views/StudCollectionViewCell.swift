//
//  StudCollectionViewCell.swift
//  GongSa
//
//  Created by taechan on 2022/11/11.
//

import UIKit
import SnapKit

final class StudCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "StudCollectionViewCell"
    
    private let wrapperLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(size: 12, family: .medium)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.backgroundColor = .gsLightGray
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("chip collection view cell - init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        addSubview(wrapperLabel)
        
        wrapperLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(45)
            make.height.equalTo(28)
            make.edges.equalToSuperview()
        }
    }
    
    public func configure(text: String) {
        wrapperLabel.text = text
    }
    
    public func selectTitleLabel() {
        self.wrapperLabel.backgroundColor = .gsGreen
        self.wrapperLabel.textColor = .gsWhite
        self.wrapperLabel.font = UIFont.pretendard(size: 12, family: .bold)
    }
    
    public func unselectTitleLabel() {
        self.wrapperLabel.backgroundColor = .gsLightGray
        self.wrapperLabel.textColor = .gsBlack
        self.wrapperLabel.font = UIFont.pretendard(size: 12, family: .medium)
    }
}
