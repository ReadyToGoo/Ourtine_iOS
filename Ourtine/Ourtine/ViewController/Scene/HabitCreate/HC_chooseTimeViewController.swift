//
//  HC_chooseScheduleViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit
import SnapKit

class HabitCreate_chooseTimeViewController: UIViewController {
    
    let HC_chooseTimeView = HabiCreate_chooseTimeView()
    
    // MARK: - HCFlowData에 저장되는 값잆니다.
    var startTime: Date?
    var endTime: Date?
    var dateSet = Set<String>()
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_chooseTimeView
        HabitCreateFlowManager.shared.printself()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.HC_chooseTimeView.nextBtn.isEnabled = false
        self.HC_chooseTimeView.lineView2.isHidden = true
        
        // MARK: - 시작 시간 버튼
        self.HC_chooseTimeView.startTime_btn.addTarget(self, action: #selector(showTimePicker), for: .touchUpInside)
        
        // MARK: - 시작 시간 피커
        self.HC_chooseTimeView.startTimePicker.addTarget(self, action: #selector(setTimeLabel), for: .valueChanged)
        
        // MARK: - 종료 시간 버튼
        self.HC_chooseTimeView.endTime_btn.addTarget(self, action: #selector(showTimePicker), for: .touchUpInside)
        
        // MARK: - 종료 시간 피커
        self.HC_chooseTimeView.endTimePicker.addTarget(self, action: #selector(setTimeLabel), for: .valueChanged)
        
        // MARK: - 요일 버튼들에 타겟 설정
        self.addButtonTargets(stackView: self.HC_chooseTimeView.dayStack)
        
        //MARK: - nextBTN
        self.HC_chooseTimeView.nextBtn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        //MARK: - backBTN
        self.HC_chooseTimeView.navigationBar.leftButton.action = #selector(popVC)
        self.HC_chooseTimeView.navigationBar.leftButton.target = self
        
    }
    
    
    
    @objc func showTimePicker(_ sender: ColorToggleButton){
        
        lazy var timePicker = UIDatePicker()
        
        // 시작 시간 버튼을 누른 경우 timePicker에 startTimePicker할당
        if sender == self.HC_chooseTimeView.startTime_btn {
            timePicker = self.HC_chooseTimeView.startTimePicker
        }
        
        // 종료 시간 버튼을 누른 경우 timePicker에 endTimePicker할당
        if sender == self.HC_chooseTimeView.endTime_btn {
            timePicker = self.HC_chooseTimeView.endTimePicker
        }
        
        /// 버튼의 isOff value가 탭하자마자 바로 바뀌고, 그 후 isOff변수를 참조하여 함수를 사용합니다.
        // 피커뷰 열렸을 때
        if sender.isOn {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.HC_chooseTimeView.lineView2.isHidden = false
                timePicker.isHidden = false
                timePicker.snp.updateConstraints {
                    $0.height.equalTo(timePicker.intrinsicContentSize.height)
                }
                self.HC_chooseTimeView.layoutIfNeeded()
            })
            
        }
        // 피커뷰 닫혔을 때
        else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.HC_chooseTimeView.lineView2.isHidden = true
                timePicker.isHidden = true
                timePicker.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                self.HC_chooseTimeView.layoutIfNeeded()
            })
        }
  
    }
    
    
    /// 피커의 결과값에 따른 해당 라벨의 text를 수정하는 함수입니다.
    @objc func setTimeLabel(_ sender: UIDatePicker) {
        
        lazy var label = UILabel()
        
        // 시작 시간 피커에서 정했을 때
        if sender == self.HC_chooseTimeView.startTimePicker {
            label = self.HC_chooseTimeView.startTimeLabel_main
            self.startTime = sender.date
        }
        // 종료 시간 피커에서 정했을 때
        if sender == self.HC_chooseTimeView.endTimePicker {
            label = self.HC_chooseTimeView.endTimeLabel_main
            self.endTime = sender.date
        }
        
        //라벨의 text 설정
        let inputText = sender.date.toString(format: "a hh시 mm분")
        
        let attributedText = NSMutableAttributedString(string: inputText)
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 2))
        attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 2, length: 8))
        label.attributedText = attributedText
        checkToGO() // 조건 체크
    }
    
    /// 요일 버튼들에 setDays()함수를 target설정합니다.
    private func addButtonTargets(stackView: UIStackView) {
        for subView in stackView.arrangedSubviews {
            if let button = subView as? ColorToggleButton {
                button.addTarget(self, action: #selector(setDays), for: .touchDown)
            }
        }
    }
    
    /// 요일 버튼들이 해당 요일에 맞춰 true/false에 따라 요일 리스트를 작업합니다.
    @objc func setDays(_ sender: ColorToggleButton) {
        // 요일 설정을 위한 변수입니다.
        let day: String?
        
        // 버튼의 텍스트에 따라 switch로 요일을 판별합니다.
        switch sender.titleLabel?.text {
            
        case "월":
            day = "mon"
        case "화":
            day = "tue"
        case "수":
            day = "wed"
        case "목":
            day = "thu"
        case "금":
            day = "fri"
        case "토":
            day = "sat"
        case "일":
            day = "sun"
        default:
            day = nil
            
        }
        
        // 요일을 찾지 못한 경우 리턴합니다.
        guard let dayInstance = day else { return }
        
        // 여기에서만 .isOn을 반대로 사용합니다
        
        // 취소되었을 경우, 반환할 요일 리스트에 해당 요일을 삭제합니다.
        if sender.isOn{
            //print("\(dayInstance) 삭제")
            self.dateSet.remove(dayInstance)
        }
        // 선택되었을 경우, 반환할 요일 리스트에 해당 요일을 추가합니다.
        else {
            //print("\(dayInstance) 추가")
            self.dateSet.insert(dayInstance)
        }
        
        // 해당 페이지의 조건을 만족했는지 확인합니다
        checkToGO()
    }
    
    /// 해당 페이지의 조건을 만족했는지 확인합니다
    private func checkToGO() {
        
        if let _ = self.startTime, let _ = self.endTime, !self.dateSet.isEmpty {
            self.HC_chooseTimeView.nextBtn.isEnabled = true
        }
        else {
            self.HC_chooseTimeView.nextBtn.isEnabled = false
        }
    }
    
    /// 해당 페이지에서 저장된 데이터를 flowdata로 보내고, 제대로 저장됐는지 확인합니다.
    private func saveToFlowData() -> Bool {
        
        // 습관 생성 플로우의 데이터를 저장
        if let startTime = self.startTime, let endTime = self.endTime {
            HabitCreateFlowManager.shared.habitInformation.habitTime.startTime = startTime
            HabitCreateFlowManager.shared.habitInformation.habitTime.endTime = endTime
            HabitCreateFlowManager.shared.habitInformation.habitTime.days = Array(dateSet)
        }
        
        // 싱글톤 클래스 객체에 값이 저장되면 넘어가도록 guarding
        guard (HabitCreateFlowManager.shared.habitInformation.habitTime.startTime != nil && HabitCreateFlowManager.shared.habitInformation.habitTime.endTime != nil && HabitCreateFlowManager.shared.habitInformation.habitTime.days != nil ) else {
            print("HabitCreateFlowManager.shared.habitInformation.habitTime에 값이 저장되지 않았습니다. 다시 시도해주세요")
            return false
        }
        
        return true
    }
    
    /// 다음 뷰컨트롤러로 이동
    @objc func nextVC() {
        // 데이터 저장 실패 시 push X
        guard saveToFlowData() else { return }
        
        let viewController = HabitCreate_chooseDateViewController()
        viewController.hidesBottomBarWhenPushed = true // 탭 바 숨기기 설정
        
        self.navigationController?.pushViewController(viewController, animated: true)
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
            let ViewController = HabitCreate_chooseTimeViewController()
            return ViewController
        }
    }
}
