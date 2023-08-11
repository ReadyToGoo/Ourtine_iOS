//
//  UIImage + Circular Extension.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/11.
//

import Foundation
import UIKit

/// 이미지를 원형으로 크롭해서 반환해주는 익스텐션입니다
/// 사용 예 : UIIamge(namde:"example")?.circularCropped()
extension UIImage {
    func circularCropped() -> UIImage? {
        let imageSize = size
        let diameter = min(imageSize.width, imageSize.height)
        let xOffset = (imageSize.width - diameter) / 2
        let yOffset = (imageSize.height - diameter) / 2

        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, scale)
        defer { UIGraphicsEndImageContext() }

        let context = UIGraphicsGetCurrentContext()!
        context.beginPath()
        context.addEllipse(in: CGRect(origin: .zero, size: CGSize(width: diameter, height: diameter)))
        context.closePath()
        context.clip()

        draw(in: CGRect(x: -xOffset, y: -yOffset, width: imageSize.width, height: imageSize.height))

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
