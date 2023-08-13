//
//  ParticipateViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/09.
//

import UIKit
import SnapKit

class WaitingViewController: UIViewController {
    
    // Dummy Data
    let tempUserName = "은지"
    let tempUserHabit = "반려동물 물주기"

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
    
    // leftSecond: 남은 시간 카운트다운
    private let leftSecond: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "5"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 80, weight: .bold)
        return label
    }()
    
    // memberPhrase
    private let memberPhrase: UILabel = {
        let label = UILabel()
        label.text = "먼저 입장한 친구들"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    // layout
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 32
        layout.itemSize = CGSize(width: 72, height: 96)
        return layout
    }()
    
    // collectionView
    private lazy var memberCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.contentInset = .zero
        view.backgroundColor = .white.withAlphaComponent(0.6)
        view.clipsToBounds = true
        view.register(WaitingMemberCollectionViewCell.self, forCellWithReuseIdentifier: "WaitingMemberCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // 카운트다운 함수
    func startCountDown() {
        var leftTime = 5
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            leftTime -= 1
            
            if leftTime > 0 {
                self.leftSecond.text = String(leftTime)
            } else {
                timer.invalidate()
                self.updateView()
                self.leftSecond.text = ""
            }
        }
    }
    
    
    // 카운트다운 완료시 화면 전환 함수
    @objc func updateView() {
//        let vc = ParticipatingViewController()
        let vc = ReviewViewController()
        navigationController?.pushViewController(vc, animated: false)
    }

    override func viewDidLoad() {
        view.backgroundColor = .app_PrimaryColor
        
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        super.viewDidLoad()
        
        [
            habitPhrase,
            leftSecond,
            memberCollectionView,
            memberPhrase
        ].forEach {view.addSubview($0)}
        

        // phraseLabel
        let text = "\(tempUserName)님, \(postPositionText(tempUserHabit))\n시작해봐요!"
        habitPhrase.text = text
        habitPhrase.halfTextColorChange(fullText: text, changeText: postPositionText(tempUserHabit), color: .white)
        
        // memberCollectionView
        self.memberCollectionView.dataSource = self
        
        // Setting
        startCountDown()
        setConstraints()
    }
    
    // Layout Constraint
    private func setConstraints() {
        // habitPhrase
        habitPhrase.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(108.67)
            make.centerX.equalToSuperview()
        }
        
        // leftSecond
        leftSecond.snp.makeConstraints { make in
            make.top.equalTo(habitPhrase.snp.bottom).offset(150.4)
            make.centerX.equalToSuperview()
        }
        
        // memberCollectionView
        memberCollectionView.snp.makeConstraints { make in
            make.top.equalTo(leftSecond.snp.bottom).offset(223.02)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        // memberPhrase
        memberPhrase.snp.makeConstraints { make in
            make.top.equalTo(memberCollectionView.snp.top).offset(12)
            make.leading.equalTo(memberCollectionView.snp.leading).offset(16)
        }
    }
    
}

extension WaitingViewController: UICollectionViewDataSource {
    // numOfCell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Dummy_memberList.count
    }
    
    // contentOfCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaitingMemberCollectionViewCell.id, for: indexPath) as? WaitingMemberCollectionViewCell else { return UICollectionViewCell() }
        cell.getMemberData(data: Dummy_memberList[indexPath.row])
        
//        cell.prepare(image: UIImage(named: ), text: <#T##String?#>)
        return cell
    }
}

import SwiftUI
struct WaitingViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = WaitingViewController()
            return ViewController
        }
    }
}

