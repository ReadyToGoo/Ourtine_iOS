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
        
        self.tabBar.barTintColor = .systemGray6
        self.tabBar.tintColor = .black
        self.tabBar.isTranslucent = false
        
        let firstVC = UINavigationController(rootViewController: MainViewController())
        firstVC.tabBarItem.title = "Main"
        
        let secondVC = UINavigationController(rootViewController: MainViewController())
        secondVC.tabBarItem.title = "참여"
        
        let thirdVC = UINavigationController(rootViewController: HabitJoinViewController())
        thirdVC.tabBarItem.title = "습관개설"
        
        let fourthVC = UINavigationController(rootViewController: MainViewController())
        fourthVC.tabBarItem.title = "마이페이지"
        
        // 탭바에 VCs 설정
        viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
        
        
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
