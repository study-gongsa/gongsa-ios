//
//  ChipCollectionViewCell.swift
//  GongSa
//
//  Created by taechan on 2022/09/26.
//

import UIKit
import SnapKit

final class ChipCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "ChipCollectionViewCell"

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(size: 12, family: .medium)
        label.textAlignment = .center
        label.layer.cornerRadius = 28 / 2
        label.clipsToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.gsGreen.cgColor
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
        addSubview(self.titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(45)
            make.height.equalTo(28)
        }
    }
    
    public func selectTitleLabel() {
        self.titleLabel.backgroundColor = .gsGreen
        self.titleLabel.textColor = .gsWhite
    }
    
    public func unselectTitleLabel() {
        self.titleLabel.backgroundColor = .gsWhite
        self.titleLabel.textColor = .gsBlack
    }
}
