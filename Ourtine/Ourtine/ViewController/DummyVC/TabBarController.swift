//
//  TabBarController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/14.
//

import UIKit
import SnapKit

/// 임시 탭바입니당
class AppTabBarController: UITabBarController {
    
    //let tabBarHeight:Int = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .black
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundColor = .white
        
        let firstVC = UINavigationController(rootViewController: HomeViewController())
        firstVC.tabBarItem.image = UIImage(systemName: "house")
        firstVC.tabBarItem.title = "홈"
        
        
        let secondVC = DarkStatusBar_NavigationController(rootViewController: HabitDiscoverViewController())
        secondVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        secondVC.tabBarItem.title = "탐색"
        
        let thirdVC = UINavigationController(rootViewController: DummyViewController())
        thirdVC.tabBarItem.image = UIImage(systemName: "map")
        thirdVC.tabBarItem.title = "습관개설"
        
        let fourthVC = UINavigationController(rootViewController: DummyViewController())
        fourthVC.tabBarItem.image = UIImage(systemName: "person")
        fourthVC.tabBarItem.title = "마이페이지"
        
        // 탭바에 VCs 설정
        viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
        
        //self.tabBar.
        
//        self.tabBar.snp.makeConstraints { make in
//            make.width.equalToSuperview()
//            make.height.equalTo(100)
//            make.bottom.equalToSuperview()
//            make.horizontalEdges.equalTo(self.view.snp.horizontalEdges)
//
//        }
        
        
    }
}

import SwiftUI
struct AppTabBarController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = AppTabBarController()
            return ViewController
        }
    }
}
