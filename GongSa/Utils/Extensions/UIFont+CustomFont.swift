//
//  UIFont+CustomFont.swift
//  GongSa
//
//  Created by taechan on 2022/08/11.
//

import UIKit

extension UIFont {
    enum Family: String {
        case Black, Bold, ExtraBold, ExtraLight, Light, Medium, Regular, SemiBold, Thin
    }

    static func pretendard(size: CGFloat = 14, family: Family = .Regular) -> UIFont {
        return UIFont(name: "Pretendard-\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
