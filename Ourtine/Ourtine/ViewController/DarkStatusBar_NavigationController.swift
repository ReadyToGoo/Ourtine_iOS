//
//  DarkStatusBar_NavigationController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/02.
//

import UIKit

/// navigationController에서 파생되는 VC들의 상태바 텍스트 색을 검정으로 설정한 navigationController입니다.
class DarkStatusBar_NavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
