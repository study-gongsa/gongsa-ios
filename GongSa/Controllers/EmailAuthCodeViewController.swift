//
//  EmailAuthCodeViewController.swift
//  GongSa
//
//  Created by taechan on 2022/08/17.
//

import UIKit

class EmailAuthCodeViewController: UIViewController {

    // MARK: - Properties
    public var emailAddress: String? {
        didSet {
            emailLabel.text = emailAddress
        }
    }

    private var errorAlertMessage: String?

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
        textField.heightAnchor.constraint(equalToConstant: 47).isActive = true
        return textField
    }()

    private lazy var resendCodeButton: UIButton = {
        let button = UIButton.underLined(withText: "코드를 받지 못하셨나요?", withColor: UIColor.gsDarkGray)
        button.addTarget(self, action: #selector(resendCodeButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton.main(withTitle: "다음")
        button.backgroundColor = UIColor.gsGreen
        button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton.main(withTitle: "취소")
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
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
        if sender.text?.count ?? 0 >= 7 { return }
        codeTextField.text = sender.text
    }

    @objc private func resendCodeButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "스팸함을 확인해주세요.", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("취소", comment: "취소"), style: .default, handler: { _ in
            // do nothing
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @objc private func nextButtonTapped(_ sender: UIButton) {
        authenticateCode { response in
            switch response {
            case .success(let response):
                debugPrint("DEBUG - code authentication success", response)
                self.navigationController?.pushViewController(EmailAuthDoneViewController(), animated: true)
            case .failure(let error):
                self.showCodeErrorAlert()
                debugPrint("DEBUG - code authentication error", error)
            }
        }
    }

    @objc private func cancelButtonTapped() {
        let alert = UIAlertController(title: "로그인 화면으로 돌아가시겠습니까?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("취소", comment: "취소"), style: .default, handler: { _ in
            // do nothing
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "확인"), style: .default, handler: { _ in
            if let loginVC = self.navigationController?.viewControllers
                .filter({$0 is LoginViewController}) // 로그인 화면으로 변경 필요
                .first {
                self.navigationController?.popToViewController(loginVC, animated: true)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Helpers

    private func showCodeErrorAlert() {
        let invalidCodeFormat: Bool = errorAlertMessage == "인증번호는 6자여야 합니다" || errorAlertMessage == "인증번호는 필수값 입니다."
        let alert = UIAlertController(title: errorAlertMessage, message: invalidCodeFormat ? "" : "코드를 재요청 합니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("취소", comment: "취소"), style: .default, handler: { _ in
            // do nothing
        }))
        if invalidCodeFormat {
            self.present(alert, animated: true)
            return
        }
        alert.addAction(UIAlertAction(title: NSLocalizedString("재요청", comment: "재요청"), style: .default, handler: { _ in
            // request server to re-send mail
            self.authenticateCode { response in
                switch response {
                case .success(let response):
                    debugPrint("DEBUG - resend code authentication success", response)
                case .failure(let error):
                    debugPrint("DEBUG - resend code authentication error", error)
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    private func authenticateCode(completion: @escaping (Result<Bool, APIError>) -> Void) {
        guard let emailAddress = self.emailAddress else {
            completion(.failure(APIError.invalidMail))
            return
        }
        let params = [
            "authCode": codeTextField.text ?? "",
            "email": emailAddress
        ]
        AuthService.shared.authenticateCode(params: params) { response in
            if response.value?.location != nil {
                // error
                self.errorAlertMessage = response.value?.msg
                completion(.failure(APIError.invalidCode))
            } else {
                // success
                completion(.success(true))
            }
        }
    }

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
                                         target: self,
                                         action: #selector(cancelButtonTapped))
        // target: navigationController
        // action: #selector(UINavigationController.popViewController(animated:))
        backButton.tintColor = UIColor.gsLightGray
        navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = "이메일 인증 코드 입력"
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.gsBlack]
    }
}

extension EmailAuthCodeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        codeTextField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
