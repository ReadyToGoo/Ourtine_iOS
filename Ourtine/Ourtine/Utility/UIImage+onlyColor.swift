//
//  UIImage+onlyColor.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/01.
//

import UIKit

// 단일색으로 된 UIImage를 생성하는 함수
func createImageWithColor(color: UIColor, size: CGSize) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    let context = UIGraphicsGetCurrentContext()
    
    context?.setFillColor(color.cgColor)
    context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}
