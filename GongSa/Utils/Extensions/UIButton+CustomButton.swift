//
//  UIButton+CustomButton.swift
//  GongSa
//
//  Created by taechan on 2022/08/18.
//

import UIKit

extension UIButton {
    static func underLinedButton(withText text: String, withColor color: UIColor) -> UIButton {
        let button = UIButton()
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.pretendard(size: 12, family: .Medium) ])
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }

    static func mainButton(withTitle title: String) -> UIButton {
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
