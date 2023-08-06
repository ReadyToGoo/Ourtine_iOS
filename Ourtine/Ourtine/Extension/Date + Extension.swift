//
//  Date + Extension.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/06.
//

import Foundation

extension Date {
    /// ex : format = "yyyy-MM-dd HH:mm"
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
