//
//  makeAlert.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/17.
//

import Foundation
import UIKit

func makeAlert(title: String, message: String, completion: (() -> Void)?) {
    // 경고창을 생성하고 설정합니다.
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    // 경고창에 액션 추가 (확인 버튼)
    let okAction = UIAlertAction(title: "확인", style: .default) { _ in
        // 클로저가 전달되었다면 실행합니다.
        completion?()
    }
    alert.addAction(okAction)
    
    // 현재 활성화된 뷰 컨트롤러에서 경고창을 표시합니다.
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let currentViewController = windowScene.windows.first?.rootViewController {
            currentViewController.present(alert, animated: true, completion: nil)
    }
}
/* 사용 예시
 makeAlert(title: "사용자 알림", message: "무언가 잘못되었습니다.", completion: {
     print("확인 버튼을 눌렀습니다.")
     // 원하는 동작을 추가하세요.
 })
 */
