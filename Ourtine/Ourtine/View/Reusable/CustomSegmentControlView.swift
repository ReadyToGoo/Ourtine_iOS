//
//  SegmentControlView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/18.
//

import UIKit

/// 검색 테이블을 스위칭할 세그먼트 컨트롤입니다.
class CustomSegmentControl: UISegmentedControl {
    
    //세그먼트의 디폴트 높이입니다.
    static let selfHeight = 50.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.selectedSegmentTintColor = .clear
        
        // 배경 색 제거
        self.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        //self.backgroundColor = .systemGray6
    
        // Segment 구분 라인 제거
        self.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        // Segment 요소 추가
        self.insertSegment(withTitle: "습관 찾기", at: 0, animated: true)
        self.insertSegment(withTitle: "유저 닉네임", at: 1, animated: true)
        
        // 디폴트로 선택된 segment
        self.selectedSegmentIndex = 0
        
        // 선택 되어 있지 않을때 폰트 및 폰트컬러
        self.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ], for: .normal)
        
        // 선택 안했을 때 배경색
        //self.setBackgroundColor(.blue, for: .normal)
        
        
        // 선택 되었을때 폰트 및 폰트컬러
        self.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ], for: .selected)
        
        // 선택 했을 때 배경색
        //self.setBackgroundColor(.systemGray, for: .selected)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



import SwiftUI
struct CustomSegmentControlView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let navBar = CustomSegmentControl(frame: CGRect(x: 0, y: 0, width: 184, height: CustomSegmentControl.selfHeight))
            return navBar
        }
        .frame(width: 184, height: CustomSegmentControl.selfHeight, alignment: .center)
        .previewLayout(.sizeThatFits)

    }
}
