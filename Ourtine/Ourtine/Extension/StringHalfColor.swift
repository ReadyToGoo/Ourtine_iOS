//
//  StringHalf.swift
//  Ourtine
//
//  Created by eunji on 2023/08/11.
//

import UIKit

extension UILabel {
    func halfTextColorChange (fullText: String, changeText: String, color: UIColor) {
        let originalString: NSString = fullText as NSString
        let range = (originalString).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(.foregroundColor, value: color, range: range)
        self.attributedText = attribute
    }
}
