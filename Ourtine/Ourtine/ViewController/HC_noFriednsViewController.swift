//
//  HabitCreate_noFriednsViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/09.
//

import UIKit

class HabitCreate_noFriednsViewController: UIViewController {
    
    let HC_noFriends_View = HabitCreate_noFriednsView()
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_noFriends_View
        HabitCreateFlowManager.shared.printself()
    }
    
    // 뷰 로딩된 후에 한번만
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 네비게이션 바 보이지 않게
        self.navigationController?.navigationBar.isHidden = true
                       
        //MARK: - nextBTN
        self.HC_noFriends_View.goPublicBtn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        self.HC_noFriends_View.laterBtn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        //MARK: - backBTN
        self.HC_noFriends_View.navigationBar.leftButton.action = #selector(popVC)
        self.HC_noFriends_View.navigationBar.leftButton.target = self
    }
    
    @objc func nextVC(_ sender: UIButton) {
        
        if sender == self.HC_noFriends_View.goPublicBtn {
            //print("public")
            HabitCreateFlowManager.shared.habitInformation.habitType = .publicType
            
            self.navigationController?.pushViewController(HabitCreate_finalViewController(), animated: true)
        }
        
        if sender == self.HC_noFriends_View.laterBtn {
            //print("later")
            self.navigationController?.popToRootViewController(animated: true)
        }

    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}



import SwiftUI
struct HabitCreate_noFriednsViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_noFriednsViewController()
            return ViewController
        }
    }
}
