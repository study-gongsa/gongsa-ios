//
//  UITextField+CustomTextField.swift
//  GongSa
//
//  Created by taechan on 2022/11/12.
//

import UIKit

extension UITextField {
    
    static func gray(with placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.keyboardType = .numberPad
        tf.textAlignment = .center
        tf.textColor = .gsBlack
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gsLightGray.cgColor
        tf.font = UIFont.pretendard(size: 12, family: .medium)
        tf.textAlignment = .center
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        return tf
    }
}
