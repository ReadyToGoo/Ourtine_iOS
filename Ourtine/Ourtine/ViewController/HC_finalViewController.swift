//
//  HC_finalViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/09.
//

import UIKit

class HabitCreate_finalViewController: UIViewController {
    
    let HC_final_View = HabitCreate_finalView()
    
    var isPrivate: Bool = true
    // 테스트용
    let title_private = "[아침마다 운동하기]\n초대장을 발송했어요!"
    let bottom_private = "친구가 응답하면 알람을 드릴게요!"
    let title_public = "축하해요!\n2 번째 습관이 만들어졌어요!"
    let bottom_public = "팀원이 참여하면 알람을 드릴게요!"
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_final_View
        HabitCreateFlowManager.shared.printself()
    }
    
    // 뷰 로딩된 후에 한번만
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView(isPrivate)
        // 기본 네비게이션 바 보이지 않게
        self.navigationController?.navigationBar.isHidden = true
                       
        //MARK: - nextBTN
        self.HC_final_View.okBtn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        //MARK: - backBTN
        self.HC_final_View.navigationBar.leftButton.action = #selector(popVC)
        self.HC_final_View.navigationBar.leftButton.target = self
    }
    
    /// 색 넣을 마지막 인덱스 찾아줌
    private func checkColorIndex(input:String, target:String) -> Int? {
        let mainString = input
        let searchString = target

        if let range = mainString.range(of: searchString) {
            let startIndex = mainString.distance(from: mainString.startIndex, to: range.lowerBound)
            return startIndex
        }
        
        return nil
    }
    
    private func updateView(_ isPrivate:Bool) {
        if isPrivate {
            let lastColorindex = checkColorIndex(input: title_private, target: "\n") ?? 0
            let attributedText = NSMutableAttributedString(string: title_private)
            attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 0, length: lastColorindex))
            
            self.HC_final_View.topLabel.attributedText = attributedText
            self.HC_final_View.topLabel.font = .systemFont(ofSize: 25, weight: .heavy)
            
            self.HC_final_View.bottomLabel.text = bottom_private
        }
        else{
            let firstColorIndex = (checkColorIndex(input: title_public, target: "\n") ?? 0) + 1
            print(firstColorIndex)
            let attributedText = NSMutableAttributedString(string: title_public)
            attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: firstColorIndex, length: 7))
            
            self.HC_final_View.topLabel.attributedText = attributedText
            self.HC_final_View.topLabel.font = .systemFont(ofSize: 25, weight: .heavy)
            
            self.HC_final_View.bottomLabel.text = bottom_public
        }
    }
    
    @objc func nextVC(_ sender: UIButton) {
//        self.navigationController?.pushViewController(HabitCreate_introduceViewController(), animated: true)
        print("습관 프로필 호출")
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}



import SwiftUI
struct HabitCreate_finalViewViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_finalViewController()
            return ViewController
        }
    }
}
