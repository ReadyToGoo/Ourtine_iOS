//
//  LineSpacing.swift
//  Ourtine
//
//  Created by eunji on 2023/08/03.
//

import UIKit

/*
 HOW TO USE
 label.setLetterSpacing() // 0.5
 label.setLetterSpacing(kernValue: [원하는값])
 */

extension UILabel {
    func setLetterSpacing(kernValue:Double = 0.5) {
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
    }
}
