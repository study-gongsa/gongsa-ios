//
//  EmailAuthCodeViewController.swift
//  GongSa
//
//  Created by taechan on 2022/08/17.
//

import UIKit

class EmailAuthCodeViewController: UIViewController {

    // MARK: - Properties

    private let emailGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "입력하신 이메일 주소"
        label.font = UIFont.pretendard(size: 16, family: .Medium)
        label.textColor = UIColor.gsBlack
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "gongsa@google.com"
        label.font = UIFont.pretendard(size: 16, family: .Bold)
        label.textColor = UIColor.gsBlack
        return label
    }()

    private lazy var codeContainerView: UIView = {
        let view = Utilities().inputContainerView(text: "코드를 입력하세요 (6자리)", textField: codeTextField)
        return view
    }()

    private let codeTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()

    private lazy var resendCodeButton: UIButton = {
        let button = UIButton.underLinedButton(withText: "코드를 받지 못하셨나요?", withColor: UIColor.gsDarkGray)
        button.addTarget(self, action: #selector(resendCodeButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton.mainButton(withTitle: "다음")
        button.backgroundColor = UIColor.gsGreen
        button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton.mainButton(withTitle: "취소")
        button.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
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
    @objc private func textFieldDidChange(_ sender: UITextField) {

    }

    @objc private func resendCodeButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "인증 코드가 만료되었습니다.", message: "코드를 재요청 합니다.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("취소", comment: "취소"), style: .default, handler: { _ in
            // do something
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("재요청", comment: "재요청"), style: .default, handler: { _ in
            // do something
        }))
        self.present(alert, animated: true, completion: nil)

    }

    @objc private func nextButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(EmailAuthDoneViewController(), animated: true)
    }

    @objc private func cancelButtonTapped(_ sender: UIButton) {
        if let registrationViewController = navigationController?.viewControllers
            .filter({$0 is RegistrationViewController})
            .first {
            navigationController?.popToViewController(registrationViewController, animated: true)
        }
    }

    // MARK: - Helpers
    private func configureUI() {
        view.addSubview(emailGuideLabel)
        view.addSubview(emailLabel)
        view.addSubview(codeContainerView)
        view.addSubview(resendCodeButton)
        view.addSubview(nextButton)
        view.addSubview(cancelButton)

        emailGuideLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 152, paddingLeft: 24, paddingRight: 24)
        emailLabel.anchor(top: emailGuideLabel.bottomAnchor, left: emailGuideLabel.leftAnchor, right: emailGuideLabel.rightAnchor, paddingTop: 12)
        codeContainerView.anchor(top: emailLabel.bottomAnchor, left: emailGuideLabel.leftAnchor, right: emailGuideLabel.rightAnchor, paddingTop: 40)
        resendCodeButton.anchor(top: codeContainerView.bottomAnchor, left: emailGuideLabel.leftAnchor, paddingTop: 30)
        nextButton.anchor(top: resendCodeButton.bottomAnchor, left: emailGuideLabel.leftAnchor, right: emailGuideLabel.rightAnchor, paddingTop: 62)
        cancelButton.anchor(top: nextButton.bottomAnchor, left: emailGuideLabel.leftAnchor, right: emailGuideLabel.rightAnchor, paddingTop: 12)
    }

    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(named: "back"),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        backButton.tintColor = UIColor.gsLightGray
        navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = "이메일 인증 코드 입력"
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.gsBlack]
    }
}
