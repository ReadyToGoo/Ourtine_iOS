//
//  VoteViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/12.
//

import UIKit
import SnapKit

// 팀원 습관 확인 View입니다.
class VoteViewController: UIViewController, ParticipatingMemberCollectionViewDelegate {
    
    func didSelectMember(_ memberData: MemberModel?) {
        let vc = OthersViewController()
        vc.selectedMember = memberData
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(vc, animated: true)
    }
    
    
    private let bigPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .app_PrimaryColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.text = "팀원들의 습관을\n확인해보세요!"
        label.setLetterSpacing()
        return label
    }()
    
    private let smallPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "투표 마감 시간"
        label.setLetterSpacing()
        return label
    }()
    
    private let leftSecondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .app_PrimaryColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.setLetterSpacing()
        return label
    }()
    
    private let unitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "초"
        label.setLetterSpacing()
        return label
    }()
    
    private let memberView: ParticipatingMemberCollectionView = {
        let view = ParticipatingMemberCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let voteBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .app_PrimaryColor
        config.background.cornerRadius = 8
        config.contentInsets = NSDirectionalEdgeInsets(top: 17.5, leading: 73.5, bottom: 17.5, trailing: 73.5)
        
        var titleAttr = AttributedString.init("베스터 습관러 투표하러 가기")
        titleAttr.font = .systemFont(ofSize: 16, weight: .semibold)
        config.attributedTitle = titleAttr
        
        let button = UIButton(configuration: config)
        return button
    }()
    
    @objc private func voteBtnTapped() {
        let vc = VoteMemberViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private let unionImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "OrangeFilledUnion")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white

        navigationController?.isNavigationBarHidden = true

        super.viewDidLoad()
        
        [
            unionImage,
            bigPhraseLabel,
            smallPhraseLabel,
            leftSecondLabel,
            unitLabel,
            memberView,
            voteBtn
        ].forEach {view.addSubview($0)}

        setupUI()
        setConstraints()
        
        memberView.delegate = self
    }
    
    private func setupUI() {
        startCountDown()
        
        // TODO: Get Left Second
        leftSecondLabel.text = "40"
        
        voteBtn.addTarget(self, action: #selector(voteBtnTapped), for: .touchUpInside)
    }
    
    // TODO: 임시
    func startCountDown() {
        var leftTime = 40
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            leftTime -= 1
            
            if leftTime > 0 {
                self.leftSecondLabel.text = String(leftTime)
            } else {
                timer.invalidate()
                self.leftSecondLabel.text = "0"
            }
        }
    }
    

    private func setConstraints() {
        // bigPhraseLabel
        bigPhraseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(118)
            make.centerX.equalToSuperview()
        }
        
        // smallPhraseLabel
        smallPhraseLabel.snp.makeConstraints { make in
            make.top.equalTo(bigPhraseLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(123)
        }
        
        // leftSecondLabel
        leftSecondLabel.snp.makeConstraints { make in
            make.centerY.equalTo(smallPhraseLabel)
            make.leading.equalTo(smallPhraseLabel.snp.trailing).offset(8)
        }
        
        // unitLabel
        unitLabel.snp.makeConstraints { make in
            make.centerY.equalTo(smallPhraseLabel)
            make.leading.equalTo(leftSecondLabel.snp.trailing).offset(4)
        }
        
        // memberView
        memberView.snp.makeConstraints { make in
//            make.top.equalTo(unitLabel.snp.bottom).offset(83.16)
            make.top.equalToSuperview().offset(319.9)
            make.centerX.equalToSuperview()
            make.width.equalTo(272)
            make.height.equalTo(300)
        }
        
        // voteBtn
        voteBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32)
        }
        
        unionImage.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(memberView)
            make.height.equalTo(218.78)
            make.width.equalTo(187.5)
        }
    }

}

import SwiftUI
struct VoteViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = VoteViewController()
            return ViewController
        }
    }
}
