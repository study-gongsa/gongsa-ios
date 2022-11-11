//
//  Utilities.swift
//  GongSa
//
//  Created by taechan on 2022/08/02.
//

import UIKit
import SnapKit

class Utilities {

    func inputContainerView(text: String, textField: UITextField, error: UILabel? = nil) -> UIView {

        let textLabel = UILabel()
        textLabel.text = text
        textLabel.textColor = UIColor.gsDarkGray
        textLabel.font = UIFont.pretendard(size: 14, family: .bold)

        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 90).isActive = true

        view.addSubview(textLabel)
        view.addSubview(textField)
        guard let error = error else {
            textLabel.anchor(top: view.topAnchor, left: view.leftAnchor,
                             right: view.rightAnchor)
            textField.anchor(top: textLabel.bottomAnchor, left: textLabel.leftAnchor,
                             bottom: view.bottomAnchor, right: textLabel.rightAnchor,
                             paddingTop: 8, height: 47)
            return view
        }

        view.addSubview(error)

        error.text = "잘못된 형식의 입력입니다."

        textLabel.anchor(top: view.topAnchor, left: view.leftAnchor,
                         right: view.rightAnchor)
        textField.anchor(top: textLabel.bottomAnchor, left: textLabel.leftAnchor,
                         right: textLabel.rightAnchor, paddingTop: 8, height: 47)
        error.anchor(top: textField.bottomAnchor, left: textLabel.leftAnchor,
                     bottom: view.bottomAnchor, right: textLabel.rightAnchor,
                     paddingTop: 4)

        textLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        error.setContentHuggingPriority(.defaultHigh, for: .vertical)

        return view
    }

    func aggrementContainerView(checkbox: UIButton, text: String, button: UIButton) -> UIView {

        let textLabel = UILabel()
        textLabel.textColor = UIColor.gsDarkGray
        textLabel.font = UIFont.pretendard(size: 12, family: .medium)
        textLabel.text = text

        let view = UIStackView(arrangedSubviews: [checkbox, textLabel, button])
        view.heightAnchor.constraint(equalToConstant: 35).isActive = true
        view.distribution = .equalCentering

        view.addSubview(checkbox)
        checkbox.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor)

        view.addSubview(textLabel)
        textLabel.anchor(top: view.topAnchor, left: checkbox.rightAnchor, bottom: view.bottomAnchor, paddingLeft: 12)

        view.addSubview(button)
        button.anchor(top: view.topAnchor, left: textLabel.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 98)

        return view
    }

    func textField(withPlaceholder placeholder: String) -> UITextField {
        let textField = TextField()
        textField.placeholder = placeholder
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gsLightGray.cgColor
        textField.font = UIFont.pretendard(size: 16, family: .medium)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gsLightGray, NSAttributedString.Key.font: UIFont.pretendard(size: 16, family: .medium)])
        textField.textColor = UIColor.gsBlack

        return textField
    }

    func errorLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.pretendard(size: 12, family: .medium)
        label.textColor = UIColor.gsRed
        label.heightAnchor.constraint(equalToConstant: 14).isActive = true
        label.isHidden = true
        return label
    }

    func checkbox(withImage image: String) -> UIButton {
        let checkbox = UIButton()
        checkbox.setImage(UIImage(named: image)?.withRenderingMode(.alwaysTemplate), for: .normal)
        checkbox.imageView?.contentMode = .scaleAspectFit
        checkbox.tintColor = UIColor.gsDarkGray
        checkbox.setDimensions(width: 14.67, height: 14.67)
        return checkbox
    }

    func buttonWithLabel(withButton button: UIButton, labelText text: String) -> UIView {
        let label = UILabel()   /// text next to the button
        label.text = text
        label.font = .pretendard(size: 14, family: .medium)

        let stackView = UIStackView(arrangedSubviews: [button, label])
        stackView.axis = .horizontal

        button.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(button.snp.right).inset(-6)
        }

        return stackView
    }

}

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
