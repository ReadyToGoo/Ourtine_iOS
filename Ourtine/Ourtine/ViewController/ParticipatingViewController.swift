//
//  ParticipatingViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/11.
//

import UIKit
import SnapKit

class ParticipatingViewController: UIViewController {
    
    let participantNum = 4
    
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
        // TODO: Test시 -> 상황에 따라 TargetTime 변경
        let targetTime = "00:00:59"
        
        if let targetTime = dateFormatter.date(from: targetTime) {
            let currentTime = Date()
            
            // Convert the times to the Same Date
            // 동일 날짜의 시간 비교할 수 있도록
            let calendar = Calendar.current
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
        let vc = VoteViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    // members
    private let memberCollectionView: ParticipatingMemberCollectionView = {
        // Create CollectionView Layer
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 52
        layout.minimumLineSpacing = 52
        let collectionView = ParticipatingMemberCollectionView(collectionViewLayout: layout)
        collectionView.view.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // camerBtn
    private let cameraBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white.withAlphaComponent(0.4)
        config.background.cornerRadius = 16
        // TODO: Change image as HIFI Icon
        config.image = UIImage(systemName: "camera")?.withTintColor(.white)
        config.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 67.5, bottom: 18, trailing: 67.5)
        
        let button = UIButton(configuration: config)
        return button
    }()
    
    @objc func cameraBtnTapped() {
        // TODO: Change Connected ViewController
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    @objc func cameraCloseBtnTapped() {
        // TODO: Need Fix
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .app_PrimaryColor
        
        addChild(memberCollectionView)
        [
            habitPhrase,
            countDownLabel,
            memberCollectionView.view,
            cameraBtn
        ].forEach {view.addSubview($0)}


        // habitPhrase
        let text = "\(tempUserName)님, \(postPositionText(tempUserHabit))\n오늘도 활기차게!"
        habitPhrase.text = text
        habitPhrase.halfTextColorChange(fullText: text, changeText: postPositionText(tempUserHabit))
        
        // memberCollectionView
        memberCollectionView.didMove(toParent: self)
        
        startCountDown()
        setConstraints()
        setupUI()
    }
    
    private func setupUI() {
        cameraBtn.addTarget(self, action: #selector(cameraBtnTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        // habitPhrase
        habitPhrase.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(21.9)
            make.centerX.equalToSuperview()
        }
        
        // countDownLabel
        countDownLabel.snp.makeConstraints { make in
            make.top.equalTo(habitPhrase.snp.bottom).offset(63.5)
            make.centerX.equalToSuperview()
        }
        
        // memberCollectionView
        memberCollectionView.view.snp.makeConstraints { make in
            make.top.equalTo(countDownLabel.snp.bottom).offset(54.91)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
            make.width.equalToSuperview().offset(-32).priority(.low)
            make.height.equalTo(256) // Adjust the initial height
        }
        
        
        // cameraBtn
        cameraBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-26.81)
            make.centerX.equalToSuperview()
        }
    }
    
}

import SwiftUI
import SnapKit
struct ParticipatingViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = ParticipatingViewController()
            return ViewController
        }
    }
}

