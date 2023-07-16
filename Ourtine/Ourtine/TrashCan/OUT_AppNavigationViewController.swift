//
//  AppNavigationController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/14.
//

import UIKit

class AppNavigationViewController: UINavigationController {
    
    private var backButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0.0)]
        return backButtonAppearance
    }
    
    private var backButtonImage: UIImage? {
        let image = UIImage(systemName: "chevron.left")
        return image
        //?.withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: -12.0, bottom: -5.0, right: 0.0))
    }
    
    private func setNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
    
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
    
        /// transitionMaskImage파라미터: push되거나 pop될때의 backButton 마스크 이미지
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backButtonAppearance = backButtonAppearance
    
        ///back버튼만 색 지정
        //appearance.backIndicatorImage.withTintColor(.app_ButtonColor1)

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    
        /// navigationItem의 버튼 색상을 .white로 지정
        navigationBar.tintColor = .app_ButtonColor1
    }
    
//    func pushViewController(_ viewController: UIViewController, animated: Bool, _ option: pushOption? = nil) {
//        switch option {
//        case .search:
//            //pushViewController(viewController, animated: animated)
//            let rightButton = UIBarButtonItem(image:UIImage(systemName: "magnifyingglass"))
//            navigationItem.rightBarButtonItem = rightButton
//            pushViewController(viewController, animated: animated)
//        default:
//            pushViewController(viewController, animated: animated)
//        }
//    }
    
    override func loadView() {
        super.loadView()
        //setNavBarAppearance()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
