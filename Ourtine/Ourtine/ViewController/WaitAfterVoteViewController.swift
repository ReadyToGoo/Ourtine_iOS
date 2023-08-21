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
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = .clear
        updateBackground()
        
        if didVoted {
            voted()
        } else {
            unVoted()
        }
        
        updateView()
        
        
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
    
    private func updateView() {
        // TODO: move to other view.
        // TODO: if 현재시간 > 종료 예정 시간
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.dismiss(animated: false)
        }
    }
    
    private func updateBackground() {
        view.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    

}

import SwiftUI

struct WaitAfterVoteViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = WaitAfterVoteViewController()
            return ViewController
        }
    }
}
