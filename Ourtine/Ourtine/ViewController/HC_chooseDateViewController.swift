//
//  HC_chooseDateViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/07.
//

import UIKit
import SnapKit

class HabitCreate_chooseDateViewController: UIViewController {
    
    let HC_chooseDateView = HabiCreate_chooseDateView()
    
    var didSet_startDate: Bool = false
    var didSet_endDate: Bool = false
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_chooseDateView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.HC_chooseDateView.nextBtn.isEnabled = false
        self.HC_chooseDateView.lineView2.isHidden = true
        
        // MARK: - 시작 시간 버튼
        self.HC_chooseDateView.startDate_btn.addTarget(self, action: #selector(showTimePicker), for: .touchUpInside)
        
        self.HC_chooseDateView.startDatePicker.addTarget(self, action: #selector(setTimeLabel), for: .valueChanged)
        
        // MARK: - 종료 시간 버튼
        self.HC_chooseDateView.endDate_btn.addTarget(self, action: #selector(showTimePicker), for: .touchUpInside)
        
        self.HC_chooseDateView.endDatePicker.addTarget(self, action: #selector(setTimeLabel), for: .valueChanged)
        
        //MARK: - nextBTN
        self.HC_chooseDateView.nextBtn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        //MARK: - backBTN
        self.HC_chooseDateView.navigationBar.leftButton.action = #selector(popVC)
        self.HC_chooseDateView.navigationBar.leftButton.target = self
        
    }
    
    @objc func showTimePicker(_ sender: ColorToggleButton){
        
        lazy var datePicker = UIDatePicker()
        
        // 시작 시간 버튼을 누른 경우 timePicker에 startTimePicker할당
        if sender == self.HC_chooseDateView.startDate_btn {
            datePicker = self.HC_chooseDateView.startDatePicker
        }
        
        // 종료 시간 버튼을 누른 경우 timePicker에 endTimePicker할당
        if sender == self.HC_chooseDateView.endDate_btn {
            datePicker = self.HC_chooseDateView.endDatePicker
        }
        
        /// 버튼의 isOn value가 탭하자마자 바로 바뀌고, 그 후 isOn변수를 참조하여 함수를 사용합니다.
        // 피커뷰 열렸을 때
        if sender.isOn {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.HC_chooseDateView.lineView2.isHidden = false
                datePicker.isHidden = false
                datePicker.snp.updateConstraints {
                    //$0.height.equalTo(datePicker.intrinsicContentSize.height)
                    $0.height.equalTo(300) //나중에 intrinsicSize로 바꿔야함
                }
                self.HC_chooseDateView.layoutIfNeeded()
            })
            
        }
        // 피커뷰 닫혔을 때
        else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.HC_chooseDateView.lineView2.isHidden = true
                datePicker.isHidden = true
                datePicker.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                self.HC_chooseDateView.layoutIfNeeded()
            })
        }
  
    }
    
    
    /// 피커의 결과값에 따른 해당 라벨의 text를 수정하는 함수입니다.
    @objc func setTimeLabel(_ sender: UIDatePicker) {
        
        lazy var label = UILabel()
        
        // 시작 시간 피커에서 정했을 때
        if sender == self.HC_chooseDateView.startDatePicker {
            label = self.HC_chooseDateView.startDateLabel_main
            self.didSet_startDate = true
        }
        // 종료 시간 피커에서 정했을 때
        if sender == self.HC_chooseDateView.endDatePicker {
            label = self.HC_chooseDateView.endDateLabel_main
            self.didSet_endDate = true
        }
        //라벨의 text 설정
        let inputText = sender.date.toString(format: "yyyy.MM.dd")
        
        let attributedText = NSMutableAttributedString(string: inputText)
        attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 0, length: 10))
        label.attributedText = attributedText
        
        //테스트용 
        checkSet()
    }
    
    /// 필수 요건을 만족했는지 확인하는 함수
    private func checkSet() {
        if self.didSet_endDate && self.didSet_startDate {
            self.HC_chooseDateView.nextBtn.isEnabled = true
        }
    }
    
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(HabitCreate_memberCountViewController(), animated: true)
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}

import SwiftUI
struct HabitCreate_chooseDateViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_chooseDateViewController()
            return ViewController
        }
    }
}
