//
//  SearchFilterModel.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/20.
//

import Foundation

enum searchFilter {
    case CREATED_DATE
    case RECRUITING
    case START_DATE
    
    func toString() -> String {
        switch self {
        case .CREATED_DATE:
            return "CREATED_DATE"
        case .RECRUITING:
            return "RECRUITING"
        case .START_DATE:
            return "START_DATE"
        }
    }
}
