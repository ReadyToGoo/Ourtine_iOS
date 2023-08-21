//
//  Int + time Extension.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/21.
//

import Foundation

extension Int {
    var minuteToSecond: Int {
        return self * 60
    }
    
    var hourToSecond: Int {
        return self * 3600
    }
}
