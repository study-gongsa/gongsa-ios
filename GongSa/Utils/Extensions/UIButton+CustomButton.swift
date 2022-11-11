//
//  UIButton+CustomButton.swift
//  GongSa
//
//  Created by taechan on 2022/08/18.
//

import UIKit

extension UIButton {
    static func underLined(withText text: String, withColor color: UIColor, withSize size: CGFloat?=12) -> UIButton {
        let button = UIButton()
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.pretendard(size: size ?? 12, family: .medium) ])
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }

    static func main(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.gsWhite, for: .normal)
        button.backgroundColor = UIColor.gsLightGray
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.pretendard(size: 16, family: .bold)
        button.isEnabled = false
        return button
    }

    static func radio() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "toggleOff"), for: .normal)
        return button
    }
    
    static func gray(with title: String) -> UIButton {
        let button = UIButton()
        let attributedString = NSAttributedString(string: title,
                                                  attributes:
                                                    [NSAttributedString.Key.foregroundColor: UIColor.gsLightGray,
                                                     NSAttributedString.Key.font: UIFont.pretendard(size: 12, family: .medium)
                                                    ])
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gsLightGray.cgColor
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }
}
