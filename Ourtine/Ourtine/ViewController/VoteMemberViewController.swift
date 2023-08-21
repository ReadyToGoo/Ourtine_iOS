//
//  VoteMemberViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/21.
//

import UIKit
import SnapKit

class VoteMemberViewController: UIViewController, ParticipatingMemberCollectionViewDelegate {
    
    private var isVoteBtnTapped: Bool = false
    
    weak var delegate: ParticipatingMemberCollectionViewDelegate?
    
    var selectedMemberData: [MemberModel] = []
    var selectedCellCount: Int = 0
    
    func didSelectMember(_ memberData: MemberModel?) {
        print("selected member data: ", memberData ?? "FAIL")
        if let selectedData = memberData {
            if selectedMemberData.contains(selectedData) {
                selectedMemberData.removeAll { $0.userId == selectedData.userId }
                selectedCellCount -= 1
            } else {
                selectedMemberData.append(selectedData)
                selectedCellCount += 1
            }
        }
        
        let selectedUserIds = selectedMemberData.map {$0.userId}
        print("\(selectedUserIds)")
        print(selectedCellCount)
        isSelectionMade = selectedCellCount > 0
    }
    
    func didChangeSelection(_ isSelected: Bool) {
        isSelectionMade = isSelected
        updateVoteButtonState()
    }
    
    
    private var isSelectionMade: Bool = false {
        didSet {
            updateVoteButtonState()
        }
    }
    
    private let bigPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .app_PrimaryColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.text = "팀원들의 습관을\n골라주세요!"
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
    
    private let collectionView: ParticipatingMemberCollectionView = {
        let view = ParticipatingMemberCollectionView()
        view.participantNum = 4
        view.cellShouldShowSelectedImage = true
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
        // TODO: selectedMemberData API로 전송
        // TODO: 투표 종료 시간 되면 화면 이동.
//        let vc = ReviewViewController()
//        navigationController?.pushViewController(vc, animated: false)
        isVoteBtnTapped = true
        let vc = WaitAfterVoteViewController()
        vc.didVoted = isSelectionMade
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        
        [
            bigPhraseLabel,
            smallPhraseLabel,
            leftSecondLabel,
            collectionView,
            unitLabel,
            voteBtn
        ].forEach {view.addSubview($0)}

        setupUI()
        setConstraints()
        collectionView.delegate = self
        startCountDown()
    }
    

    private func setupUI() {
        // TODO: Get Left Second
        
        leftSecondLabel.text = "23"
        
        voteBtn.addTarget(self, action: #selector(voteBtnTapped), for: .touchUpInside)
        
        updateVoteButtonState()
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
        
        // collectionView
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(319.9)
            make.centerX.equalToSuperview()
            make.width.equalTo(272)
            make.height.equalTo(300)
            
        }
        
        // voteBtn
        voteBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.trailing.equalTo(-31)
            make.leading.equalTo(31)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32)
        }
    }
    
    
    
    private func updateVoteButtonState() {
        voteBtn.isEnabled = isSelectionMade
        
        if isSelectionMade {
            // Enable the button and set the appropriate title
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                .foregroundColor: UIColor.white
            ]
            let titleAttr = NSAttributedString(string: "투표 완료하기", attributes: attributes)
            voteBtn.setAttributedTitle(titleAttr, for: .normal)
        } else {
            // Disable the button and set a disabled title
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                .foregroundColor: UIColor.gray
            ]
            let titleAttr = NSAttributedString(string: "베스터 습관러 투표하러 가기", attributes: attributes)
            voteBtn.setAttributedTitle(titleAttr, for: .normal)
        }
    }
    
    private func startCountDown() {
        var leftTime = 5
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            leftTime -= 1
            
            if leftTime > 0 {
                self.leftSecondLabel.text = String(leftTime)
            } else {
                timer.invalidate()
                self.presentModal()
                self.leftSecondLabel.text = ""
            }
        }
    }
    
    private func presentModal() {
        let vc = WaitAfterVoteViewController()
        vc.didVoted = isVoteBtnTapped ? isSelectionMade : false
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }

}

import SwiftUI

struct VoteMemberViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = VoteMemberViewController()
            return ViewController
        }
    }
}
