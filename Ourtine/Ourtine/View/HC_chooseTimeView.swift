//
//  HC_chooseScheduleView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit
import SnapKit

class HabiCreate_chooseTimeView: UIView {
    
    ///시간 선택하는 피커
    lazy var startTimePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels // 굴려서 시간정하는 타입
        picker.datePickerMode = .time   // 시간 설정
        //picker.locale = Locale(identifier: "ko-KR") // 기본 위치 한국으로
        picker.timeZone = .autoupdatingCurrent // 시간대 반영
        return picker
    }()
    
    lazy var endTimePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels // 굴려서 시간정하는 타입
        picker.datePickerMode = .time   // 시간 설정
        //picker.locale = Locale(identifier: "ko-KR") // 기본 위치 한국으로
        picker.timeZone = .autoupdatingCurrent // 시간대 반영
        return picker
    }()
    
    /// 커스텀 네비게이션 바
    lazy var navigationBar : Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    /// 화면 타이틀
    lazy var topLabel : UILabel = {
        let label = UILabel()
        label.text = "언제 진행할 지 알려주세요!"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    /// 타이틀 아래 서브타이틀 - 부제목
    lazy var secondLabel : UILabel = {
        let label = UILabel()
        label.text = "시간과 요일을 정해주세요"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    /// #시간대 라벨
    lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.text = "#시간대"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    ///시작 시간 왼쪽 오른쪽 라벨 +  버튼
    lazy var startTimeView = UIView()
    
        /// 시작 시간 라벨
        lazy var startTimeLabel_Left : UILabel = {
            let label = UILabel()
            label.text = "시작 시간"
            label.textColor = .black
            label.font = .systemFont(ofSize: 15, weight: .medium)
            return label
        }()
        
        /// 시간 라벨
        lazy var startTimeLabel_main : UILabel = {
            let label = UILabel()
            label.text = "AM 00시 00분"
            label.textColor = .black
            label.font = .systemFont(ofSize: 15, weight: .medium)
            return label
        }()
        
        /// 피커 show 버튼
        lazy var startTime_btn : ColorToggleButton = {
            let btn = ColorToggleButton()
            btn.selectedColor = btn.normalColor
            btn.addImage(normal: UIImage(systemName: "chevron.down"), selected: UIImage(systemName: "chevron.up"))
            btn.tintColor = .app_BrightnessColor40
           return btn
        }()
    
    /// 구분선
    lazy var lineView : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.app_BrightnessColor100
        return line
    }()
    
    ///종료  시간 왼쪽 오른쪽 라벨 +  버튼
    lazy var endTimeView = UIView()
    
        /// "종료 시간" 라벨
        lazy var endTimeLabel_Left : UILabel = {
            let label = UILabel()
            label.text = "종료 시간"
            label.textColor = .black
            label.font = .systemFont(ofSize: 15, weight: .medium)
            return label
        }()
        
        /// 시간 라벨
        lazy var endTimeLabel_main : UILabel = {
            let label = UILabel()
            label.text = "PM 00시 00분"
            label.textColor = .black
            label.font = .systemFont(ofSize: 15, weight: .medium)
            return label
        }()
        
        /// 피커 show 버튼
        lazy var endTime_btn : ColorToggleButton = {
            let btn = ColorToggleButton()
            btn.selectedColor = btn.normalColor
            btn.addImage(normal: UIImage(systemName: "chevron.down"), selected: UIImage(systemName: "chevron.up"))
            btn.tintColor = .app_BrightnessColor40
           return btn
        }()
    
    /// 요일 라벨 + 요일 스택
    lazy var dayView = UIView()
    
        /// #요일 라벨
        lazy var dateLabel : UILabel = {
            let label = UILabel()
            label.text = "#요일"
            label.textColor = .black
            label.font = .systemFont(ofSize: 20, weight: .heavy)
            return label
        }()
    
        /// 요일 선택 버튼 포함한 스택
        lazy var dayStack : UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            //stack.distribution = .equalSpacing
            stack.distribution = .fillEqually
            stack.spacing = 10
            stack.backgroundColor = .white
            return stack
        }()
    
            lazy var monBtn: ColorToggleButton = {
                let btn = ColorToggleButton()
                btn.setTitle("월", for: .normal)
                return btn
            }()
            
            lazy var tueBtn: ColorToggleButton = {
                let btn = ColorToggleButton()
                btn.setTitle("화", for: .normal)
                return btn
            }()
            
            lazy var wedBtn: ColorToggleButton = {
                let btn = ColorToggleButton()
                btn.setTitle("수", for: .normal)
                return btn
            }()
        
            lazy var thuBtn: ColorToggleButton = {
                let btn = ColorToggleButton()
                btn.setTitle("목", for: .normal)
                return btn
            }()
            
            lazy var friBtn: ColorToggleButton = {
                let btn = ColorToggleButton()
                btn.setTitle("금", for: .normal)
                return btn
            }()
            
            lazy var satBtn: ColorToggleButton = {
                let btn = ColorToggleButton()
                btn.setTitle("토", for: .normal)
                return btn
            }()
        
            lazy var sunBtn: ColorToggleButton = {
                let btn = ColorToggleButton()
                btn.setTitle("일", for: .normal)
                return btn
            }()
    
    lazy var nextBtn: HabitCreateFlowButton = {
        let btn = HabitCreateFlowButton()
        btn.setTitle("다음", for: .normal)
        return btn
    }()

    
    func addSubviews(){
        [
            startTimeLabel_Left,
            startTimeLabel_main,
            startTime_btn
        ].forEach { self.startTimeView.addSubview($0)}
        
        [
            endTimeLabel_Left,
            endTimeLabel_main,
            endTime_btn
        ].forEach { self.endTimeView.addSubview($0)}
        
        [
            monBtn,
            tueBtn,
            wedBtn,
            thuBtn,
            friBtn,
            satBtn,
            sunBtn
            
        ].forEach { self.dayStack.addArrangedSubview($0)}
        
        [
            dateLabel,
            dayStack
        ].forEach { self.dayView.addSubview($0)}
        
        [
            navigationBar,
            topLabel,
            secondLabel,
            timeLabel,
            lineView,
            startTimeView,
            startTimePicker,
            endTimeView,
            endTimePicker,
            dayView,
            nextBtn
        ].forEach {self.addSubview($0)}
    }
    
    func setConstraint() {
        
        navigationBar.snp.makeConstraints {
            $0.top.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        topLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(5)
            $0.leading.equalTo(topLabel)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom).offset(40)
            $0.leading.equalTo(topLabel)
        }
        
        // MARK: - 시작시간 라인
        startTimeView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(30)
        }
        
            startTimeLabel_Left.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview()
            }
            
            startTime_btn.snp.makeConstraints {
                $0.centerY.equalTo(startTimeLabel_Left)
                $0.trailing.equalToSuperview()
            }

            startTimeLabel_main.snp.makeConstraints {
                $0.centerY.equalTo(startTimeLabel_Left)
                $0.trailing.equalTo(startTime_btn).offset(-25)
            }
        
        // MARK: - 중간 구분선
        lineView.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalTo(startTimeView)
            $0.top.equalTo(startTimeView.snp.bottom).offset(5)
            $0.centerX.equalTo(startTimeView)
        }
        
        // MARK: - 시작 시간 피커
        startTimePicker.snp.makeConstraints {
            $0.width.equalTo(lineView)
            $0.height.equalTo(0)
            $0.top.equalTo(lineView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        // MARK: - 종료 시간 라인
        
        endTimeView.snp.makeConstraints {
            $0.top.equalTo(startTimePicker.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(30)
        }
        
            endTimeLabel_Left.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview()
            }
            
            endTime_btn.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview()
            }

            endTimeLabel_main.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(endTime_btn).offset(-25)
            }
        
        // MARK: - 종료 시간 피커
        endTimePicker.snp.makeConstraints {
            $0.width.equalTo(lineView)
            $0.height.equalTo(0)
            $0.top.equalTo(endTimeView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        // MARK: - "#요일" 라벨 + 요일 버튼 스택 뷰
        dayView.snp.makeConstraints {
            $0.top.equalTo(endTimePicker.snp.bottom).offset(40)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        
            dateLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.top.equalToSuperview().offset(20)
            }
            
            dayStack.snp.makeConstraints{
                $0.height.equalTo(50)
                $0.width.equalToSuperview().multipliedBy(0.85)
                $0.top.equalTo(dateLabel.snp.bottom).offset(40)
                $0.centerX.equalToSuperview()
            }
        
        nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide ).multipliedBy(0.95)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.startTimeLabel_main.text = Date().toString(format: "a hh시 mm분")
        self.endTimeLabel_main.text = Date().toString(format: "a hh시 mm분")
        addSubviews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI
struct HabitCreate_chooseScheduleView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_chooseTimeViewController()
            return ViewController
        }
    }
}


