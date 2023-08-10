//
//  HC_memberCountViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/07.
//

import UIKit

class HabitCreate_memberCountViewController: UIViewController {
    
    let HC_memberCountView = HabitCreate_memberCountView()
    
    // MARK: - HCFlowData에 저장되는 값잆니다.
    var memberCount: Int?
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_memberCountView
        HabitCreateFlowManager.shared.printself()
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
    
    /// 해당 페이지의 조건을 만족했는지 확인합니다
    private func checkToGO() {
        
        guard let count = self.memberCount else {
            print("memberCount에 값이 없습니다")
            return }
        
        if count > 0 && count <= 6 {
            self.HC_memberCountView.nextBtn.isEnabled = true
        }
        else {
            self.HC_memberCountView.nextBtn.isEnabled = false
        }
        
    }
    
    /// 해당 페이지에서 저장된 데이터를 flowdata로 보내고, 제대로 저장됐는지 확인합니다.
    private func saveToFlowData() -> Bool {
        
        // 습관 생성 플로우의 데이터를 저장
        if let count = self.memberCount {
            HabitCreateFlowManager.shared.habitInformation.habitMemberNum = count
        }

        // 싱글톤 클래스 객체에 값이 저장되면 넘어가도록 guarding
        guard (HabitCreateFlowManager.shared.habitInformation.habitMemberNum != nil ) else {
            print("HabitCreateFlowManager.shared.habitInformation.habitMemberNum에 값이 저장되지 않았습니다. 다시 시도해주세요")
            return false
        }
        
        return true
    }
    
    @objc func nextVC() {
        
        // 데이터 저장 실패 시 push X
        guard saveToFlowData() else { return }
        
        let viewController = HabitCreate_selectFriednsViewController()
        viewController.hidesBottomBarWhenPushed = true // 탭 바 숨기기 설정
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}

/// 텍스트필드의 delegate입니다.
extension HabitCreate_memberCountViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        ///최신 상태의 텍스트
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        self.memberCount = Int(newText!) ?? -1
        
        checkToGO()
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

