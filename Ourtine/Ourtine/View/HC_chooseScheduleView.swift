//
//  HC_chooseScheduleView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit
import SnapKit

class HabitCreate_chooseScheduleView: UIView {
    
    lazy var navigationBar : Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    lazy var topLabel : UILabel = {
        let label = UILabel()
        label.text = "언제 진행할 지 알려주세요!"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    lazy var secondLabel : UILabel = {
        let label = UILabel()
        label.text = "시간과 요일을 정해주세요"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.text = "#시간대"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    

    lazy var startTimeLabel_Left : UILabel = {
        let label = UILabel()
        label.text = "시작 시간"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    lazy var startTimeLabel_main : UILabel = {
        let label = UILabel()
        label.text = "AM 00시 00분"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    lazy var startTime_btn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.tintColor = .app_BrightnessColor40
        return btn
    }()
    
    lazy var lineView : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.app_BrightnessColor100
        return line
    }()
    
    lazy var endTimeLabel_Left : UILabel = {
        let label = UILabel()
        label.text = "종료 시간"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    lazy var endTimeLabel_main : UILabel = {
        let label = UILabel()
        label.text = "PM 00시 00분"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    lazy var endTime_btn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.tintColor = .app_BrightnessColor40
        return btn
    }()
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.text = "#요일"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    lazy var nextBtn: HabitCreateFlowButton = {
        let btn = HabitCreateFlowButton()
        btn.setTitle("다음", for: .normal)
        return btn
    }()

    
    func addSubviews(){
        [
            navigationBar,
            topLabel,
            secondLabel,
            timeLabel,
            startTimeLabel_Left,
            startTimeLabel_main,
            startTime_btn,
            lineView,
            endTimeLabel_Left,
            endTimeLabel_main,
            endTime_btn,
            dateLabel,
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
        
        startTimeLabel_Left.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(20)
            $0.leading.equalTo(timeLabel.snp.leading).offset(10)
        }
        
        startTime_btn.snp.makeConstraints {
            $0.centerY.equalTo(startTimeLabel_Left)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        startTimeLabel_main.snp.makeConstraints {
            $0.centerY.equalTo(startTimeLabel_Left)
            $0.trailing.equalTo(startTime_btn).offset(-25)
        }
        
        lineView.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.top.equalTo(startTimeLabel_Left.snp.bottom).offset(5)
            $0.leading.equalTo(startTimeLabel_Left)
            $0.trailing.equalTo(startTime_btn)
        }
        
        endTimeLabel_Left.snp.makeConstraints {
            $0.top.equalTo(lineView).offset(5)
            $0.leading.equalTo(startTimeLabel_Left)
        }
        
        endTime_btn.snp.makeConstraints {
            $0.centerY.equalTo(endTimeLabel_Left)
            $0.trailing.equalTo(startTime_btn)
        }
        
        endTimeLabel_main.snp.makeConstraints {
            $0.centerY.equalTo(endTimeLabel_Left)
            $0.trailing.equalTo(startTimeLabel_main)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(endTimeLabel_Left.snp.bottom).offset(40)
            $0.leading.equalTo(topLabel)
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
            let ViewController = HabitCreate_chooseScheduleViewController()
            return ViewController
        }
    }
}


