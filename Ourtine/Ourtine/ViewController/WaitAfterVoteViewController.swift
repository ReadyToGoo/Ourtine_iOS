//
//  WaitAfterVoteViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/21.
//

import UIKit
import SnapKit

class WaitAfterVoteViewController: UIViewController {
    
    var didVoted: Bool = false
    
    private var unVotedTextOne: UILabel = {
        let label = UILabel()
        label.text = "앗"
        label.textAlignment = .center
        label.textColor = .app_SecondaryColor
        label.font = .systemFont(ofSize: 34, weight: .semibold)
        return label
    }()
    
    private var unVotedTextTwo: UILabel = {
        let label = UILabel()
        label.text = "투표시간이 지났어요!"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private var votedText: UILabel = {
        let label = UILabel()
        label.text = "투표하는 중이에요!"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        view.backgroundColor = .black.withAlphaComponent(0.6)
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        if didVoted {
            voted()
        } else {
            unVoted()
        }
    }
    
    private func unVoted() {
        [
            unVotedTextOne,
            unVotedTextTwo
        ].forEach { view.addSubview($0) }
        
        unVotedTextOne.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(291.5)
            make.centerX.equalToSuperview()
        }
        
        unVotedTextTwo.snp.makeConstraints { make in
            make.top.equalTo(unVotedTextOne).offset(57)
            make.centerX.equalToSuperview()
        }
    }
    
    private func voted() {
        view.addSubview(votedText)
        
        votedText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(388.06)
            make.centerX.equalToSuperview()
        }
    }
    

}
