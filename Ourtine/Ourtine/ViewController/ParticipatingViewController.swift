//
//  ParticipatingViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/11.
//

import UIKit

class ParticipatingViewController: UIViewController {
    
    // Dummy Data
    let tempUserName = "은지"
    let tempUserHabit = "반려동물 물주기"
    
    var countDownTimer: Timer?
    
    // TODO: WaitingViewController 코드 재사용 방법 찾아보기.
    // Habit Phrase Label: 습관 문구
    private let habitPhrase: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .app_SecondaryColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.setLetterSpacing()
        return label
    }()
    
    // countDown Label
    private let countDownLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 70, weight: .bold)
        label.text = ""
        return label
    }()
    
    func startCountDown() {
        countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountDown() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        // TODO: get targetTime using API
//        let targetTime = "23:59:59"
        let targetTime = "23:59:59"
        
        if let targetTime = dateFormatter.date(from: targetTime) {
            let currentTime = Date()
            
            // Convert the times to the Same Date
            // 동일 날짜의 시간 비교할 수 있도록
            let calendar = Calendar.current
//            let currentComponents = calendar.dateComponents([.hour, .minute, .second], from: currentTime)
            let targetComponents = calendar.dateComponents([.hour, .minute, .second], from: targetTime)
            
            // Calcute Time Difference
            let timeDifference = calendar.date(bySettingHour: targetComponents.hour!, minute: targetComponents.minute ?? 0, second: targetComponents.second ?? 0, of: currentTime)
            guard let timeInterval = timeDifference?.timeIntervalSince(currentTime) else { return print("ERROR IN TIME INTERVAL") }
            
            if timeInterval <= 0 {
                countDownLabel.text = ""
                countDownTimer?.invalidate()
                // TODO: Move To VotingView
                self.updateView()
            } else {
                let hours = Int(timeInterval) / 3600
                let minutes = (Int(timeInterval) % 3600) / 60
                let seconds = Int(timeInterval) % 60
                
                // Update countDownLabel
                countDownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
        }
    }
    
    // 카운트다운 완료시 화면 전환 함수
    @objc func updateView() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .app_PrimaryColor
        
        [
            habitPhrase,
            countDownLabel
        ].forEach {view.addSubview($0)}


        // habitPhrase
        let text = "\(tempUserName)님, \(postPositionText(tempUserHabit))\n오늘도 활기차게!"
        habitPhrase.text = text
        habitPhrase.halfTextColorChange(fullText: text, changeText: postPositionText(tempUserHabit))
        
        startCountDown()
        setConstraints()
    }
    
    private func setConstraints() {
        // habitPhrase
        habitPhrase.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(21.9)
            make.centerX.equalToSuperview()
        }
        
        // timerLabel
        countDownLabel.snp.makeConstraints { make in
            make.top.equalTo(habitPhrase.snp.bottom).offset(63.5)
            make.centerX.equalToSuperview()
        }
    }
    
}

import SwiftUI
struct ParticipatingViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = ParticipatingViewController()
            return ViewController
        }
    }
}

