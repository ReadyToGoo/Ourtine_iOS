//
//  HC_chooseScheduleViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit

class HabitCreate_chooseScheduleViewController: UIViewController {
    
    let HC_chooseScheduleView = HabitCreate_chooseScheduleView()
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_chooseScheduleView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.HC_chooseScheduleView.nextBtn.isEnabled = false
        
        
        
        //MARK: - nextBTN
        self.HC_chooseScheduleView.nextBtn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        //MARK: - backBTN
        self.HC_chooseScheduleView.navigationBar.leftButton.action = #selector(popVC)
        self.HC_chooseScheduleView.navigationBar.leftButton.target = self
        
    }
    
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(HabitCreate_chooseScheduleViewController(), animated: true)
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}

import SwiftUI
struct HabitCreate_chooseScheduleViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_chooseScheduleViewController()
            return ViewController
        }
    }
}
