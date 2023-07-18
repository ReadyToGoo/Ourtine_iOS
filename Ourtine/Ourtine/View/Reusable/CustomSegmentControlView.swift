//
//  SegmentControlView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/18.
//

import UIKit

class CustomSegmentControl: UISegmentedControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.selectedSegmentTintColor = .clear
        
        // 배경 색 제거
        self.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        //self.backgroundColor = .systemGray6
    
        // Segment 구분 라인 제거
        self.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        // Segment 요소 추가
        self.insertSegment(withTitle: "유저 닉네임", at: 0, animated: true)
        self.insertSegment(withTitle: "습관 찾기", at: 1, animated: true)
        
        self.selectedSegmentIndex = 0
        
        // 선택 되어 있지 않을때 폰트 및 폰트컬러
        self.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ], for: .normal)
        
        // 선택 안했을 때 배경색
        self.setBackgroundColor(.white, for: .normal)
        
        
        // 선택 되었을때 폰트 및 폰트컬러
        self.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ], for: .selected)
        
        // 선택 했을 때 배경색
        //segment.setBackgroundColor(.systemGray, for: .selected)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
