//
//  enterCodeView.swift
//  GongSa
//
//  Created by taechan on 2022/09/23.
//

import UIKit
import SnapKit

final class EnterCodeViewController: BasePopupViewController {

    // MARK: - Properties
    private let codeInputView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let codeInputTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "A123-B123-C123")
        textField.textAlignment = .center
        return textField
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(ALPHA)
        
        configureUI()

        addTapRecognizer()
    }

    // MARK: - Helpers
    private func configureUI() {
        self.titleLabel.text = "입장 코드"
        self.bottomButton.setTitle("입장하기", for: .normal)
        self.bottomButton.backgroundColor = .gsGreen

        view.addSubview(codeInputView)
        codeInputView.addSubview(titleLabel)
        codeInputView.addSubview(codeInputTextField)
        codeInputView.addSubview(bottomButton)

        codeInputView.snp.makeConstraints { make in
            make.width.equalTo(301)
            make.height.equalTo(184)
            make.centerY.centerX.equalToSuperview()
        }
        codeInputView.layer.cornerRadius = 14 / 2
        codeInputView.clipsToBounds = true

        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(28)
        }
        codeInputTextField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(28)
            make.width.equalTo(245)
        }
        bottomButton.snp.makeConstraints { make in
            make.top.equalTo(codeInputTextField.snp.bottom).offset(28)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(52)
        }
    }

    private func addTapRecognizer() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
    }

    // MARK: - Selectors
    @objc func handleTap(tap: UITapGestureRecognizer) {
        if tap.state == UIGestureRecognizer.State.ended {
            /// dismiss if the point at which user tapped is inside codeInputView
            let point = tap.location(in: self.view)
            if !CGRectContainsPoint(self.codeInputView.frame, point) {
                self.dismiss(animated: true)
            }
        }
    }
}
