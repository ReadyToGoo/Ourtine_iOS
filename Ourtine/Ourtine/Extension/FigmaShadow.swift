//
//  FigmaShadow.swift
//  Ourtine
//
//  Created by eunji on 2023/08/03.
//

import UIKit
/*
 HOW TO USE
 : Figma 상의 shadow 설정 그대로 적용하면 됨.
 button.layer.applyFigmaShadow(color: .black, alpha: 0.25, x: 0, y: 10, blur: 10, spread: 4)
 */
extension CALayer {
    func applyFigmaShadow(
        color: UIColor,
        alpha: Float,
        x: CGFloat,
        y: CGFloat,
        blur: CGFloat,
        spread: CGFloat
    ) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / UIScreen.main.scale
        if spread == 0 {
            shadowPath = nil
        } else {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
