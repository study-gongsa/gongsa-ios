//
//  EnterStudyGroupViewController.swift
//  GongSa
//
//  Created by taechan on 2022/10/22.
//

import UIKit
import SnapKit



final class EnterStudyGroupViewController: BasePopupViewController {
    // MARK: - Properties
    private let enterView: UIView = { return UIView() }()
    private let isCameraOnTitle: UILabel = {
        let label = UILabel();
        label.text = "카메라 여부";
        label.font = .pretendard(size: 16, family: .bold)
        return label
    }()
    private let isCameraOnText: UILabel = {
        let label = UILabel();
        label.text = "";
        label.font = .pretendard(size: 14, family: .medium)
        return label
    }()
    private let categoryTitle: UILabel = {
        let label = UILabel(); label.text = "카테고리"
        label.font = .pretendard(size: 16, family: .bold)
        return label
    }()
    private let categoryText: UILabel = {
        let label = UILabel()
        label.text = "자격증, 어학, 기타"
        label.font = .pretendard(size: 14, family: .medium)
        return label
    }()
    private let numPeopleTitle: UILabel = {
        let label = UILabel();
        label.text = "인원";
        label.font = .pretendard(size: 16, family: .bold)
        return label
    }()
    private let numPeopleText: UILabel = {
        let label = UILabel();
        label.text = "5명";
        label.font = .pretendard(size: 14, family: .medium)
        return label
    }()
    private let numPeopleHelpText: UILabel = {
//        return UILabel.customLabel()
        let label = UILabel();
        label.text = "입장 제한까지 1명 남았어요."
        label.font = .pretendard(size: 12, family: .medium)
        label.textColor = .gsLightGray
        return label
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(ALPHA)
        
        configureUI()
        
        addTapRecognizer()
        
    }
    
    // MARK: - Helpers
    
    public func configure(searchGroup: StudyGroup) {
        titleLabel.text = searchGroup.name
        isCameraOnText.text = searchGroup.isCam ? "카메라가 켜져있어요." : "카메라가 꺼져있어요."
    }
    
    private func addTapRecognizer() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(handleTap))
        tap.cancelsTouchesInView = false /// didSelectItemAt 함수 호출 안 되던 것 해결
        self.view.addGestureRecognizer(tap)
    }
    
    
    private func addSubviews() {
        enterView.addSubview(titleLabel)
        enterView.addSubview(isCameraOnTitle)
        enterView.addSubview(isCameraOnText)
        enterView.addSubview(categoryTitle)
        enterView.addSubview(categoryText)
        enterView.addSubview(numPeopleTitle)
        enterView.addSubview(numPeopleText)
        enterView.addSubview(numPeopleHelpText)
        enterView.addSubview(bottomButton)
    }
    
    private func configureUI() {
        self.bottomButton.setTitle("가입하기", for: .normal)
        self.bottomButton.titleLabel?.font = .pretendard(size: 16, family: .bold)
        self.bottomButton.backgroundColor = .gsGreen
        self.bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
        
        self.enterView.backgroundColor = .white
        self.view.addSubview(enterView)
        
        enterView.snp.makeConstraints { make in
            make.width.equalTo(313)
            make.height.equalTo(358)
            make.centerY.centerX.equalToSuperview()
        }
        enterView.layer.cornerRadius = 14 / 2
        enterView.clipsToBounds = true
        
        self.addSubviews()
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(28)
        }

        isCameraOnTitle.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).inset(-24)
        }
        isCameraOnText.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalToSuperview().inset(40)
            make.top.equalTo(isCameraOnTitle.snp.bottom).inset(-8)
        }

        categoryTitle.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(isCameraOnText.snp.bottom).inset(-24)
        }
        categoryText.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalToSuperview().inset(40)
            make.top.equalTo(categoryTitle.snp.bottom)
        }
        
        numPeopleTitle.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(categoryText.snp.bottom).inset(-24)
        }
        numPeopleText.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalToSuperview().inset(40)
            make.top.equalTo(numPeopleTitle.snp.bottom).inset(-8)
        }
        numPeopleHelpText.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalToSuperview().inset(40)
            make.top.equalTo(numPeopleText.snp.bottom).inset(-8)
        }
        
        bottomButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(numPeopleHelpText.snp.bottom).inset(-28)
            make.bottom.equalToSuperview()
        }
    
    }
    
    // MARK: - Selectors
    @objc func bottomButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func handleTap(tap: UITapGestureRecognizer) {
        if tap.state == UIGestureRecognizer.State.ended {
            /// dismiss if the point at which user tapped is inside codeInputView
            let point = tap.location(in: self.view)
            if !CGRectContainsPoint(self.enterView.frame, point) {
                self.dismiss(animated: true)
            }
        }
    }
}
