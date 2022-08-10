//
//  Utilities.swift
//  GongSa
//
//  Created by taechan on 2022/08/02.
//

import UIKit

class Utilities {

    func inputContainerView(text: String, textField: UITextField, error: UIView) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 90).isActive = true

        let textLabel = UILabel()
        textLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        textLabel.text = text
        textLabel.textColor = UIColor.gsDarkGray
        textLabel.font = UIFont.pretendard(size: 14, family: .Bold)

        view.addSubview(textLabel)
        textLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor)

        view.addSubview(textField)
        textField.anchor(top: textLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8)

        view.addSubview(error)

        error.anchor(top: textField.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 4)

        return view
    }

    func aggrementContainerView(checkbox: UIButton, text: String, button: UIButton) -> UIView {

        let textLabel = UILabel()
        textLabel.textColor = UIColor.gsDarkGray
        textLabel.font = UIFont.pretendard(size: 12, family: .Medium)
        textLabel.text = text

        let view = UIStackView(arrangedSubviews: [checkbox, textLabel, button])
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.distribution = .equalCentering

        view.addSubview(checkbox)
        checkbox.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor)

        view.addSubview(textLabel)
        textLabel.anchor(top: view.topAnchor, left: checkbox.rightAnchor, bottom: view.bottomAnchor, paddingLeft: 12)

        view.addSubview(button)
        button.anchor(top: view.topAnchor, left: textLabel.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)

        return view
    }

    func textField(withPlaceholder placeholder: String) -> UITextField {
        let textField = TextField()
        textField.heightAnchor.constraint(equalToConstant: 47).isActive = true
        textField.placeholder = placeholder
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1).cgColor
        textField.font = UIFont.pretendard(size: 16, family: .Medium)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gsLightGray, NSAttributedString.Key.font: UIFont.pretendard(size: 16, family: .Medium)])

        return textField
    }

    func errorLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.pretendard(size: 12, family: .Medium)
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

    func TOSButton() -> UIButton {
        let button = UIButton()
        let attributedString = NSAttributedString(string: "이용약관", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: UIColor.gsLightGray, NSAttributedString.Key.font: UIFont.pretendard(size: 12, family: .Medium) ])
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }

    func authButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.gsWhite, for: .normal)
        button.backgroundColor = UIColor.gsLightGray
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.pretendard(size: 16, family: .Bold)
        return button
    }
}

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
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
