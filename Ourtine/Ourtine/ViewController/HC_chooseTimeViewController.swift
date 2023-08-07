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
    
    // 필수 조건들 만족했는지 확인
    var didSet_startTime: Bool = false
    var didSet_endTime: Bool = false
    var didSet_Date: Bool = false
    
    var dateSet = Set<String>()
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_chooseTimeView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.HC_chooseTimeView.nextBtn.isEnabled = false
        
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
            self.didSet_startTime = true
        }
        // 종료 시간 피커에서 정했을 때
        if sender == self.HC_chooseTimeView.endTimePicker {
            label = self.HC_chooseTimeView.endTimeLabel_main
            self.didSet_endTime = true
        }
        
        //라벨의 text 설정
        label.text = sender.date.toString(format: "a hh시 mm분")
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
            print("\(dayInstance) 삭제")
            self.dateSet.remove(dayInstance)
            self.didSet_Date = false
        }
        // 선택되었을 경우, 반환할 요일 리스트에 해당 요일을 추가합니다.
        else {
            print("\(dayInstance) 추가")
            self.dateSet.insert(dayInstance)
            self.didSet_Date = true
        }
        
        // 테스트용 코드
        checkSet()
    }
    
    /// 필수 요건을 만족했는지 확인하는 함수
    private func checkSet() {
        if self.didSet_Date && self.didSet_endTime && self.didSet_startTime {
            self.HC_chooseTimeView.nextBtn.isEnabled = true
        }
    }
    
    /// 다음 뷰컨트롤러로 이동
    @objc func nextVC() {
        print(self.dateSet)
        self.navigationController?.pushViewController(HabitCreate_chooseDateViewController(), animated: true)
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
