//
//  HC_chooseDateView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/07.
//

import UIKit
import SnapKit

class HabiCreate_chooseDateView: UIView {
    
    ///시간 선택하는 피커
    lazy var startDatePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline // 캘린더 타입
        picker.datePickerMode = .date   // 날짜로 설정
        picker.locale = Locale(identifier: "ko-KR") // 기본 위치 한국으로
        picker.timeZone = .autoupdatingCurrent // 시간대 반영
        picker.tintColor = .app_PrimaryColor
        return picker
    }()
    
    lazy var endDatePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline // 캘린더 타입
        picker.datePickerMode = .date   // 날짜로 설정
        picker.locale = Locale(identifier: "ko-KR") // 기본 위치 한국으로
        picker.timeZone = .autoupdatingCurrent // 시간대 반영
        picker.tintColor = .app_PrimaryColor
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
        label.text = "얼마나 습관을 진행할까요?"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    /// 달력 이미지
    lazy var calendarImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "calendar")
        view.tintColor = .app_BrightnessColor100
        return view
    }()
    
    /// 기간 라벨
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.text = "기간"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    ///시작 시간 왼쪽 오른쪽 라벨 +  버튼
    lazy var startDateView = UIView()
    
        /// 시작 시간 라벨
        lazy var startDateLabel_Left : UILabel = {
            let label = UILabel()
            label.text = "시작일"
            label.textColor = .black
            label.font = .systemFont(ofSize: 15, weight: .medium)
            return label
        }()
        
        /// 시간 라벨
        lazy var startDateLabel_main : UILabel = {
            let label = UILabel()
            label.text = "현재 날짜"
            label.textColor = .black
            label.font = .systemFont(ofSize: 15, weight: .medium)
            return label
        }()
        
        /// 피커 show 버튼
        lazy var startDate_btn : ColorToggleButton = {
            let btn = ColorToggleButton()
            btn.selectedColor = btn.normalColor
            btn.addImage(normal: UIImage(systemName: "chevron.down"), selected: UIImage(systemName: "chevron.up"))
            btn.tintColor = .app_BrightnessColor40
           return btn
        }()
    
    /// 구분선
    lazy var lineView1 : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.app_BrightnessColor40
        return line
    }()
    
    ///종료  시간 왼쪽 오른쪽 라벨 +  버튼
    lazy var endDateView = UIView()
    
        /// "종료 시간" 라벨
        lazy var endDateLabel_Left : UILabel = {
            let label = UILabel()
            label.text = "종료일"
            label.textColor = .black
            label.font = .systemFont(ofSize: 15, weight: .medium)
            return label
        }()
        
        /// 시간 라벨
        lazy var endDateLabel_main : UILabel = {
            let label = UILabel()
            label.text = "현재 날짜"
            label.textColor = .black
            label.font = .systemFont(ofSize: 15, weight: .medium)
            return label
        }()
        
        /// 피커 show 버튼
        lazy var endDate_btn : ColorToggleButton = {
            let btn = ColorToggleButton()
            btn.selectedColor = btn.normalColor
            btn.addImage(normal: UIImage(systemName: "chevron.down"), selected: UIImage(systemName: "chevron.up"))
            btn.tintColor = .app_BrightnessColor40
           return btn
        }()
    
    /// 구분선
    lazy var lineView2 : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.app_BrightnessColor40
        return line
    }()
    
    lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "*일주일 단위로 기간을 설정할 수 있어요"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .app_BrightnessColor60
        return label
    }()
    
    /// 다음 버튼
    lazy var nextBtn: HabitCreateFlowButton = {
        let btn = HabitCreateFlowButton()
        btn.setTitle("다음", for: .normal)
        return btn
    }()

    
    func addSubviews(){
        //시작 라인(시작일, 날짜, 버튼)
        [
            startDateLabel_Left,
            startDateLabel_main,
            startDate_btn
        ].forEach { self.startDateView.addSubview($0)}
        
        //종료 라인(시작일, 날짜, 버튼)
        [
            endDateLabel_Left,
            endDateLabel_main,
            endDate_btn
        ].forEach { self.endDateView.addSubview($0)}
        
        //메인뷰
        [
            navigationBar,
            topLabel,
            calendarImage,
            dateLabel,
            lineView1,
            lineView2,
            startDateView,
            startDatePicker,
            endDateView,
            endDatePicker,
            noticeLabel,
            nextBtn
        ].forEach {self.addSubview($0)}
    }
    
    func setConstraint() {
        
        navigationBar.snp.makeConstraints {
            $0.top.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        topLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(30)
        }
        
        calendarImage.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(dateLabel.snp.height)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(50)
            $0.leading.equalTo(calendarImage.snp.trailing).offset(5)
        }
        
        // MARK: - 시작시간 라인
        startDateView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(30)
        }
        
            startDateLabel_Left.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview()
            }
            
            startDate_btn.snp.makeConstraints {
                $0.centerY.equalTo(startDateLabel_Left)
                $0.trailing.equalToSuperview()
            }

            startDateLabel_main.snp.makeConstraints {
                $0.centerY.equalTo(startDateLabel_Left)
                $0.trailing.equalTo(startDate_btn).offset(-25)
            }
        
        // MARK: - 중간 구분선
        lineView1.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalToSuperview()
            $0.top.equalTo(startDateView.snp.bottom).offset(5)
            $0.centerX.equalTo(startDateView)
        }
        
        // MARK: - 시작일 피커
        startDatePicker.snp.makeConstraints {
            $0.width.equalTo(lineView1)
            $0.height.equalTo(0)
            $0.top.equalTo(lineView1.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        // MARK: - 종료 시간 라인
        
        endDateView.snp.makeConstraints {
            $0.top.equalTo(startDatePicker.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(30)
        }
        
            endDateLabel_Left.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview()
            }
            
            endDate_btn.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview()
            }

            endDateLabel_main.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(endDate_btn).offset(-25)
            }
        
        
        
        lineView2.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalToSuperview()
            $0.top.equalTo(endDateView.snp.bottom).offset(5)
            $0.centerX.equalTo(startDateView)
        }
        
        // MARK: - 종료일 피커
        endDatePicker.snp.makeConstraints {
            $0.width.equalTo(lineView1)
            $0.height.equalTo(0)
            $0.top.equalTo(endDateView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(endDatePicker.snp.bottom).offset(20)
            $0.leading.equalTo(endDatePicker).offset(20)
        }
        
        nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide ).multipliedBy(0.95)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        // 라벨에 현재날짜 설정
        self.startDateLabel_main.text = Date().toString(format: "yyyy.MM.dd")
        self.endDateLabel_main.text = Date().toString(format: "yyyy.MM.dd")
        
        addSubviews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI
struct HabiCreate_chooseDateView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_chooseDateViewController()
            return ViewController
        }
    }
}
