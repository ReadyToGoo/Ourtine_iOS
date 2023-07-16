//
//  UIImage(systemname)+resize.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/15.
//

import UIKit

/// SFsymbols 이미지 변환을 위한 리사이징 함수입니다.
func getResizedSymbolImage(_ symbolImage: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
//    let symbolName = "heart"
//    let symbolImage = UIImage(systemName: symbolName)

    let size = CGSize(width: width, height: height)
    let renderer = UIGraphicsImageRenderer(size: size)
    let resizedImage = renderer.image { context in
        symbolImage.draw(in: CGRect(origin: .zero, size: size))
    }
    return resizedImage
}
