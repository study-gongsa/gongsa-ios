//
//  UILabel+CustomLabel.swift
//  GongSa
//
//  Created by taechan on 2022/10/30.
//

import UIKit

extension UILabel {
    static func customLabel(with text: String, color: UIColor, fontSize: CGFloat, fontFamily: UIFont.Family) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = .pretendard(size: fontSize, family: fontFamily)
        return label
    }
}
