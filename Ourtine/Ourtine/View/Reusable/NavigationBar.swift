//
//  NavigationBar.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/14.
//

import UIKit

/// 기본 : 네비게이션 바 - 커스텀 네비게이션 바를 위한 재사용 뷰입니다.
class Default_NavigationBar: UINavigationBar {
    
    let navItem = UINavigationItem()
    let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
class Search_NavigationBar: Default_NavigationBar {
    
    let searchBar = UISearchBar()
    let rightButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.rightButton.tintColor = .app_ButtonColor1
        navItem.rightBarButtonItem = rightButton
        self.setItems([navItem], animated: false)
        
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal) // 서치바 좌측 아이콘 삭제
        self.topItem?.titleView = searchBar // 서치바를 중앙 타이틀뷰로 설정
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



import SwiftUI // -> View 컴포넌트 하나만 볼 때
struct NavigationBar_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let navBar = Search_NavigationBar()
            return navBar
        }
        .previewLayout(.sizeThatFits)

    }
}
