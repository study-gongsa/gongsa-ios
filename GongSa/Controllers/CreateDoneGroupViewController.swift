//
//  StudyGroupCreation.swift
//  GongSa
//
//  Created by taechan on 2022/11/12.
//

import UIKit
import SnapKit

final class CreateDoneGroupViewController: UIViewController {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디그룹이 생성되었어요!"
        label.font = UIFont.pretendard(size: 20, family: .bold)
        return label
    }()
    
    private let checkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "complete")?.withTintColor(.gsLightGreen))
        return imageView
    }()
    
    private lazy var returnButton: UIButton = {
        let button = UIButton.main(withTitle: "대기실로 이동하기")
        button.addTarget(self, action: #selector(returnButtonTapped), for: .touchUpInside)
        button.backgroundColor = .gsGreen
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
    }
    // MARK: - Helpers
    private func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(checkImageView)
        view.addSubview(returnButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(144)
        }
        checkImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.top.equalTo(titleLabel.snp.bottom).inset(-70)
        }
        returnButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(24)
            make.top.equalTo(checkImageView.snp.bottom).inset(-397)
            make.bottom.equalToSuperview().inset(76)
        }
    }
    
    // MARK: - Selectors
    @objc func returnButtonTapped(_ sender: UIButton) {
        print("DEBUG - return button tapped")
    }
}
