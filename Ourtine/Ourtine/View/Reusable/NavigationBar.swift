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
    
    
    /// 네비게이션 바 우측 아이템을 3점 버튼으로 대체
    func addDotsBtn_at_Right() {
        self.dotsButton.tintColor = .app_ButtonColor1
        navItem.rightBarButtonItem = dotsButton
    }
    
    /// 네비게이션 바 중앙 센터뷰를 서치바로 대체
    func addSearchBar_at_Center() {
        self.searchBar.placeholder = " 검색어를 입력하세요"
        self.searchBar.searchTextField.textColor = .black
        self.topItem?.titleView = searchBar // 서치바를 중앙 타이틀뷰로 설정
        
    }
    
    /// 네비게이션 바 우측 아이템을 취소 버튼으로 대체
    func addCancelBtn_at_Right() {
        self.cancelButton.tintColor = .app_ButtonColor1
        navItem.rightBarButtonItem = cancelButton
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 네비게이션 바 기본 설정
        self.barTintColor = .app_UIColor1    
        self.shadowImage = UIImage()
        
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
            navBar.addDotsBtn_at_Right()
            navBar.addSearchBar_at_Center()
            return navBar
        }
        .previewLayout(.sizeThatFits)

    }
}
