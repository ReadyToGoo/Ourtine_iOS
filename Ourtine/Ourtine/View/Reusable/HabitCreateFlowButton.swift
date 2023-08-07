//
//  HabitCreateFlowButton.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit

/// 습관 개설 탭의 다음버튼 양식입니다.
/// 플로우 하단의 길고 네모난 버튼
class HabitCreateFlowButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8.0
        self.setTitleColor(.white, for: .normal)
        self.setBackgroundColor(.app_PrimaryColor, for: .normal)
        self.setBackgroundColor(.gray, for: .disabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
