//
//  RegistrationViewController.swift
//  GongSa
//
//  Created by taechan on 2022/07/31.
//

import UIKit

class RegistrationViewController: UIViewController {

    // MARK: - Properties
    var registerViewModel = RegisterViewModel()

    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(text: "이메일 주소", textField: emailTextField, error: emailError)
        return view
    }()

    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(text: "비밀번호", textField: passwordTextField, error: passwordError)
        return view
    }()

    private lazy var passwordConfirmContainerView: UIView = {
        let view = Utilities().inputContainerView(text: "비밀번호 확인", textField: passwordConfirmTextField, error: passwordConfirmError)
        return view
    }()

    private lazy var nicknameContainerView: UIView = {
        let view = Utilities().inputContainerView(text: "닉네임", textField: nicknameTextField, error: nicknameError)
        return view
    }()

    private var emailTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "이메일 주소")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()

    private var passwordTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "영문, 숫자, 특수문자를 사용한 8~16글자")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.isSecureTextEntry = true
        return textField
    }()

    private var passwordConfirmTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "위와 동일한 비밀번호 입력")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.isSecureTextEntry = true
        return textField
    }()

    private var nicknameTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "최소 1자, 최대 10자 이내로 입력")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()

    private var emailError: UILabel = {
        let label = Utilities().errorLabel()
        return label
    }()

    private var passwordError: UILabel = {
        let label = Utilities().errorLabel()
        return label
    }()

    private var passwordConfirmError: UILabel = {
        let label = Utilities().errorLabel()
        return label
    }()

    private var nicknameError: UILabel = {
        let label = Utilities().errorLabel()
        return label
    }()

    private lazy var termsOfServiceContainerView: UIView = {
        let view = Utilities().aggrementContainerView(checkbox: termsOfServiceCheckbox, text: "이용약관 동의 (필수)", button: termsOfServiceButton)
        return view
    }()

    private lazy var privacyPolicyContainerView: UIView = {
        let view = Utilities().aggrementContainerView(checkbox: privacyPolicyCheckbox, text: "개인정보 수집 및 이용 동의 (필수)", button: privacyPolicyButton)
        return view
    }()

    private lazy var eventReceiveContainerView: UIView = {
        let view = Utilities().aggrementContainerView(checkbox: eventReceiveCheckbox, text: "이벤트 정보 수신 동의 (선택)", button: eventReceiveButton)
        return view
    }()

    private lazy var termsOfServiceCheckbox: UIButton = {
        let checkbox = Utilities().checkbox(withImage: "checkbox")
        checkbox.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        return checkbox
    }()

    private let privacyPolicyCheckbox: UIButton = {
        let checkbox = Utilities().checkbox(withImage: "checkbox")
        checkbox.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        return checkbox
    }()

    private let eventReceiveCheckbox: UIButton = {
        let checkbox = Utilities().checkbox(withImage: "checkbox")
        checkbox.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        return checkbox
    }()

    private let termsOfServiceButton: UIButton = {
        let button = UIButton.underLined(withText: "약관보기", withColor: UIColor.gsLightGray)
        button.addTarget(self, action: #selector(termsOfServiceButtonTapped), for: .touchUpInside)
        return button
    }()

    private let privacyPolicyButton: UIButton = {
        let button = UIButton.underLined(withText: "약관보기", withColor: UIColor.gsLightGray)
        button.addTarget(self, action: #selector(termsOfServiceButtonTapped), for: .touchUpInside)
        return button
    }()

    private let eventReceiveButton: UIButton = {
        let button = UIButton.underLined(withText: "약관보기", withColor: UIColor.gsLightGray)
        button.addTarget(self, action: #selector(termsOfServiceButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton.main(withTitle: "회원가입")
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureNavigationBar()
        configureUI()
        configureTextFieldDelegates()

        bindViewModel()
    }

    // MARK: - Selectors

    @available(iOS 13.0, *)
    @objc func handleRegistration() {
        // TODO: 유저 register 코드 -> ViewModel
        registerViewModel.signUp { response in
            switch response {
            case .success(let data):
                debugPrint("DEBUG - signUp Success", data)

                let emailViewController = EmailAuthWaitingViewController()
                emailViewController.emailAddress = self.registerViewModel.user.value.email
                self.navigationController?.pushViewController(emailViewController, animated: true)

            case .failure(let error):
                debugPrint("DEBUG - signUp Error", error)
            }
        }
    }

    @objc private func textFieldDidChange(_ sender: UITextField) {

        switch sender {
        case self.emailTextField:
            guard let text = sender.text else { return }
            registerViewModel.user.value.email = text

        case self.passwordTextField:
            guard let text = sender.text else { return }
            registerViewModel.user.value.password = text

        case self.passwordConfirmTextField:
            guard let text = sender.text else { return }
            registerViewModel.user.value.passwordConfirm = text

        case self.nicknameTextField:
            guard let text = sender.text else { return }
            registerViewModel.user.value.nickname = text

        default:
            break
        }
    }

    @objc func checkBoxTapped(_ sender: UIButton) {
        switch sender {
        case self.termsOfServiceCheckbox:
            registerViewModel.termsOfService.value = !termsOfServiceCheckbox.isSelected
        case self.privacyPolicyCheckbox:
            registerViewModel.privacyPolicy.value = !privacyPolicyCheckbox.isSelected
        case self.eventReceiveCheckbox:
            registerViewModel.eventReceive.value = !eventReceiveCheckbox.isSelected
        default:
            break
        }
    }

    @objc func termsOfServiceButtonTapped(_ sender: UIButton) {
        let vc = TermsOfServicesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Helpers
    private func configureTextFieldDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        nicknameTextField.delegate = self
    }

    private func configureUI() {
        let authStack = UIStackView(arrangedSubviews: [emailContainerView,
                                                       passwordContainerView,
                                                       passwordConfirmContainerView,
                                                       nicknameContainerView])
        view.addSubview(authStack)
        authStack.axis = .vertical
        authStack.spacing = 10
        authStack.distribution = .fillEqually
        authStack.anchor(top: view.topAnchor, left: view.leftAnchor,
                         right: view.rightAnchor, paddingTop: 150,
                         paddingLeft: 24, paddingRight: 24)

        let agreementStack = UIStackView(arrangedSubviews: [termsOfServiceContainerView,
                                                            privacyPolicyContainerView,
                                                            eventReceiveContainerView])
        view.addSubview(agreementStack)
        agreementStack.axis = .vertical
        agreementStack.distribution = .fillEqually
        agreementStack.anchor(top: authStack.bottomAnchor, left: authStack.leftAnchor,
                              right: authStack.rightAnchor, paddingTop: 25)

        view.addSubview(registerButton)
        registerButton.anchor(top: agreementStack.bottomAnchor, left: authStack.leftAnchor,
                              bottom: view.bottomAnchor, right: authStack.rightAnchor,
                              paddingTop: 40, paddingBottom: 70)
    }

    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(named: "back"),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        backButton.tintColor = UIColor.gsLightGray
        navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = "회원가입"
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.gsBlack]
    }

    // MARK: - TODO: 리팩토링
    private func bindViewModel() {

        registerViewModel.registerButton.bind { _ in
            self.emailTextField.layer.borderColor = self.registerViewModel.emailTextFieldBorderColor
            self.emailError.text = self.registerViewModel.emailPrompt
            self.emailError.isHidden = self.registerViewModel.hideEmailPrompt

            self.nicknameTextField.layer.borderColor = self.registerViewModel.nicknameTextFieldBorderColor
            self.nicknameError.text = self.registerViewModel.nicknamePrompt
            self.nicknameError.isHidden = self.registerViewModel.hideNicknamePrompt
        }

        registerViewModel.user.bind { user in
            self.emailTextField.text = user.email
            self.emailTextField.layer.borderColor = self.registerViewModel.emailTextFieldBorderColor
            self.emailError.text = self.registerViewModel.emailPrompt
            self.emailError.isHidden = self.registerViewModel.hideEmailPrompt

            self.passwordTextField.text = user.password
            self.passwordTextField.layer.borderColor = self.registerViewModel.passwordTextFieldBorderColor
            self.passwordError.text = self.registerViewModel.passwordPrompt
            self.passwordError.isHidden = self.registerViewModel.hidePasswordPrompt

            self.passwordConfirmTextField.text = user.passwordConfirm
            self.passwordConfirmTextField.layer.borderColor = self.registerViewModel.passwordConfirmTextFieldBorderColor
            self.passwordConfirmError.text = self.registerViewModel.passwordConfirmPrompt
            self.passwordConfirmError.isHidden = self.registerViewModel.hidePasswordConfirmPrompt

            self.nicknameTextField.text = user.nickname
            self.nicknameTextField.layer.borderColor = self.registerViewModel.nicknameTextFieldBorderColor
            self.nicknameError.text = self.registerViewModel.nicknamePrompt
            self.nicknameError.isHidden = self.registerViewModel.hideNicknamePrompt

            self.toggleRegisterButton()
        }

        registerViewModel.termsOfService.bind { isSelected in
            self.termsOfServiceCheckbox.isSelected = isSelected
            self.termsOfServiceCheckbox.tintColor = self.registerViewModel.TOSColor

            self.toggleRegisterButton()
        }

        registerViewModel.privacyPolicy.bind { isSelected in
            self.privacyPolicyCheckbox.isSelected = isSelected
            self.privacyPolicyCheckbox.tintColor = self.registerViewModel.privacyColor

            self.toggleRegisterButton()
        }

        registerViewModel.eventReceive.bind { isSelected in
            self.eventReceiveCheckbox.isSelected = isSelected
            self.eventReceiveCheckbox.tintColor = self.registerViewModel.eventColor

            self.toggleRegisterButton()
        }

    }

    private func toggleRegisterButton() {
        self.registerButton.isEnabled = self.registerViewModel.shouldEnableRegisterButton
        self.registerButton.backgroundColor = self.registerViewModel.registerButtonColor
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        passwordConfirmTextField.resignFirstResponder()
        nicknameTextField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
