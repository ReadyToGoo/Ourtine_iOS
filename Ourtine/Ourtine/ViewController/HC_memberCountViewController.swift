//
//  HC_memberCountViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/07.
//

import UIKit

class HabitCreate_memberCountViewController: UIViewController {
    
    let HC_memberCountView = HabitCreate_memberCountView()
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_memberCountView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.HC_memberCountView.nextBtn.isEnabled = false
        
        self.HC_memberCountView.textField.delegate = self
        
        
        //MARK: - nextBTN
        self.HC_memberCountView.nextBtn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        //MARK: - backBTN
        self.HC_memberCountView.navigationBar.leftButton.action = #selector(popVC)
        self.HC_memberCountView.navigationBar.leftButton.target = self
        
    }
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(HabitCreate_chooseCategoryViewController(), animated: true)
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}

/// 텍스트필드의 delegate입니다.
extension HabitCreate_memberCountViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            self.HC_memberCountView.nextBtn.isEnabled = true
        }
        return true
    }
    
}


import SwiftUI
struct HabitCreate_memberCountViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_memberCountViewController()
            return ViewController
        }
    }
}

