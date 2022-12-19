//
//  UIButton+Extension.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/12/08.
//

import Foundation
import UIKit

enum ViewSide: String {
    case Left = "Left", Right = "Right", Top = "Top", Bottom = "Bottom"
}

public enum UIButtonBorderSide {
    case Top, Bottom, Left, Right
}

extension UIView {
    
    public func addBorder(side: UIButtonBorderSide, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .Top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .Bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .Left:
            border.frame = CGRect(x: 0, y: 0, width: 1, height: 40)
        case .Right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        
        self.layer.addSublayer(border)
    }
    
    func removeBorder(toSide side: ViewSide) {
        guard let sublayers = self.layer.sublayers else { return }
        var layerForRemove: CALayer?
        for layer in sublayers {
            if layer.name == side.rawValue {
                layerForRemove = layer
            }
        }
        if let layer = layerForRemove {
            layer.removeFromSuperlayer()
        }
    }
    
    func addLeftBorder() {
        let leftBorder = CALayer()
        leftBorder.borderColor = UIColor.gray.cgColor
        leftBorder.borderWidth = 0.5
        leftBorder.frame = CGRect(x: 0, y: 0, width: 1, height: 40)
        self.layer.addSublayer(leftBorder)
    }
}

