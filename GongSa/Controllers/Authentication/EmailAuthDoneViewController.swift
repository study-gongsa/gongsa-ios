//
//  EmailAuthDoneViewController.swift
//  GongSa
//
//  Created by taechan on 2022/08/17.
//

import UIKit

class EmailAuthDoneViewController: UIViewController {

    // MARK: - Helpers

    private let doneIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(named: "complete"))
        icon.contentMode = .scaleAspectFit
        return icon
    }()

    private let doneLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 인증이 완료되었습니다."
        label.textColor = .gsBlack
        label.textAlignment = .center
        label.font = .pretendard(size: 16, family: .bold)
        return label
    }()

    private let doneSubLabel: UILabel = {
        let label = UILabel()
        label.text = "공사와 함께 원하는 목표를 달성하세요."
        label.textColor = .gsBlack
        label.textAlignment = .center
        label.font = .pretendard(size: 14, family: .medium)
        return label
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton.main(withTitle: "시작하기")
        button.backgroundColor = .gsGreen
        button.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
    }

    // MARK: - Selectors
    @objc func startButtonTapped(_ sender: UIButton) {
        if let loginVC = self.navigationController?.viewControllers
            .filter({$0 is LoginViewController}) // 로그인 화면으로 변경 필요
            .first {
            self.navigationController?.popToViewController(loginVC, animated: true)
        }
    }

    // MARK: - Helpers
    private func configureUI() {
        view.addSubview(doneIcon)
        view.addSubview(doneLabel)
        view.addSubview(doneSubLabel)
        view.addSubview(startButton)

        doneIcon.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 182, paddingLeft: 157, paddingBottom: 581, paddingRight: 157)
        doneLabel.anchor(top: doneIcon.bottomAnchor, left: doneIcon.leftAnchor, right: doneIcon.rightAnchor, paddingTop: 48, paddingLeft: -67, paddingRight: -67)
        doneSubLabel.anchor(top: doneLabel.bottomAnchor, left: doneLabel.leftAnchor, right: doneLabel.rightAnchor, paddingTop: 12, paddingLeft: -9, paddingRight: -9)
        startButton.anchor(top: doneSubLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 341, paddingLeft: 32, paddingBottom: 92, paddingRight: 32)
    }

    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(named: "back"),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        backButton.tintColor = UIColor.gsLightGray
        navigationItem.leftBarButtonItem = backButton
        navigationItem.backBarButtonItem?.customView?.isHidden = true
        self.navigationItem.title = "이메일 인증"
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.gsBlack]
    }
}
