//
//  CALayer+addBorder.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/02.
//

import UIKit


///your_view.layer.addBorder([.top, .bottom], color: UIColor.white, width: 1.0)
///thickness : 선 굵기 offset: bound에서 바깥으로 떨어진 정도
extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, thickness: CGFloat, offset: CGFloat = 0) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0 - offset, width: frame.width, height: thickness)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - thickness + offset, width: frame.width, height: thickness)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0 - offset, y: 0, width: thickness, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - thickness + offset, y: 0, width: thickness, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}


