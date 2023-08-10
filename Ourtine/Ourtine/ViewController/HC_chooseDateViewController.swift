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
    
    // MARK: - HCFlowData에 저장되는 값잆니다.
    var startDate: Date?
    var endDate: Date?
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_chooseDateView
        HabitCreateFlowManager.shared.printself()
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
            self.startDate = sender.date
        }
        // 종료 시간 피커에서 정했을 때
        if sender == self.HC_chooseDateView.endDatePicker {
            label = self.HC_chooseDateView.endDateLabel_main
            self.endDate = sender.date
        }
        //라벨의 text 설정
        let inputText = sender.date.toString(format: "yyyy.MM.dd")
        
        let attributedText = NSMutableAttributedString(string: inputText)
        attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 0, length: 10))
        label.attributedText = attributedText
        
        //테스트용 
        checkToGO()
    }
    
    
    
    /// 해당 페이지의 조건을 만족했는지 확인합니다
    private func checkToGO() {
        
        if let startDate = self.startDate, let endDate = self.endDate {
            // 일주일 미만이면 가드
            guard isExceedsOneWeek(date1: startDate, date2: endDate) else {
                self.HC_chooseDateView.nextBtn.isEnabled = false
                return
            }
            
            self.HC_chooseDateView.nextBtn.isEnabled = true
        }
        else {
            self.HC_chooseDateView.nextBtn.isEnabled = false
        }
        
    }
    
    /// 해당 페이지에서 저장된 데이터를 flowdata로 보내고, 제대로 저장됐는지 확인합니다.
    private func saveToFlowData() -> Bool {
        
        // 습관 생성 플로우의 데이터를 저장
        if let startDate = self.startDate, let endDate = self.endDate {
            HabitCreateFlowManager.shared.habitInformation.habitDate.startDate = startDate
            HabitCreateFlowManager.shared.habitInformation.habitDate.endDate = endDate
        }
        
        // 싱글톤 클래스 객체에 값이 저장되면 넘어가도록 guarding
        guard (HabitCreateFlowManager.shared.habitInformation.habitDate.startDate != nil && HabitCreateFlowManager.shared.habitInformation.habitDate.endDate != nil ) else {
            print("HabitCreateFlowManager.shared.habitInformation.habitDate에 값이 저장되지 않았습니다. 다시 시도해주세요")
            return false
        }
        
        return true
    }
    
    
    @objc func nextVC() {
        
        // 데이터 저장 실패 시 push X
        guard saveToFlowData() else { return }
        
        let viewController = HabitCreate_memberCountViewController()
        viewController.hidesBottomBarWhenPushed = true // 탭 바 숨기기 설정
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 선택 날짜들이 일주일 미만인지 확인합니다.
    private func isExceedsOneWeek(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            
            if let dayDifference = components.day, dayDifference < 7 {
                return false
            }
            
            return true
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
