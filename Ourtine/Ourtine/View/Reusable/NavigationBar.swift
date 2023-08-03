//
//  NavigationBar.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/14.
//

import UIKit

/// 네비게이션 바 - 커스텀 네비게이션 바를 위한 재사용 뷰입니다.
class Custom_NavigationBar: UINavigationBar {

    let navItem = UINavigationItem() // 네비게이션 바에 들어갈 Item 리스트입니다.
    let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left")) // 네비게이션 바에 기본적으로 들어가는 돌아가기 버튼
    
    lazy var searchBar = UISearchBar() // 네비게이션 서치바
    
    lazy var dotsButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis")) // 네비게이션 점 3개 버튼
    
    lazy var cancelButton = UIBarButtonItem(title: "취소") // 네비게이션 취소 버튼
    
    lazy var alarmButton = UIBarButtonItem(image: UIImage(systemName: "bell")) // 네비게이션 알람 버튼
    
    
    
    
    /// 네비게이션 바 중앙 센터뷰를 서치바로 대체
    func addSearchBar_at_Center() {
        self.searchBar.searchTextField.leftView?.tintColor = .gray // 왼쪽 검색 버튼 틴팅
        self.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색어를 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]) // 중앙 텍스트필드 플레이스홀더 틴팅
        self.searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 10, vertical: 0) // 중앙 텍스트필드 위치 조정
        self.searchBar.searchTextField.textColor = .black // 텍스트필드 입력한 글자 색 변경
        self.searchBar.searchTextField.backgroundColor = .gray.withAlphaComponent(0.1) // 서치바 배경색 변경
        self.topItem?.titleView = searchBar // 서치바를 중앙 타이틀뷰로 설정
    }
    
    /// 네비게이션 바 우측 아이템을 취소 버튼으로 대체
    func addCancelBtn_at_Right() {
        self.cancelButton.tintColor = .app_ButtonColor1
        navItem.rightBarButtonItem = cancelButton
    }
    
    /// 네비게이션 바 우측 아이템을 3점 버튼으로 대체
    func addDotsBtn_at_Right() {
        self.dotsButton.tintColor = .app_ButtonColor1
        navItem.rightBarButtonItem = dotsButton
    }
    
    /// 네비게이션 바 우측 아이템을 알람 버튼으로 대체
    func addAlarmBtn_at_Right() {
        self.alarmButton.tintColor = .app_ButtonColor1
        navItem.rightBarButtonItem = alarmButton
    }
    
    func hideBackBtn_at_Left() {
        self.leftButton.isHidden = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 네비게이션 바 기본 설정
        self.backgroundColor = .app_UIColor1
        self.shadowImage = UIImage()
        self.barTintColor = .app_UIColor1
        
        self.leftButton.tintColor = .app_ButtonColor1
        navItem.leftBarButtonItem = leftButton
        self.setItems([navItem], animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 검색 : 네비게이션 바 - 커스텀 네비게이션 바를 위한 재사용 뷰입니다.
/// Default_NavigationBar  / 기본 : 네비게이션 바를 상속했습니다.


import SwiftUI // -> View 컴포넌트 하나만 볼 때
struct NavigationBar_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let navBar = Custom_NavigationBar()
            navBar.hideBackBtn_at_Left()
            navBar.addAlarmBtn_at_Right()
            navBar.addSearchBar_at_Center()
            return navBar
        }
        .previewLayout(.sizeThatFits)

    }
}
