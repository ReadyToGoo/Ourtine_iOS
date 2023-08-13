//
//  ReviewViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/14.
//

import UIKit

class ReviewViewController: UIViewController {
    
    let tempUserHabit = "반려식물 물주기"

    private let firstPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.setLetterSpacing()
        return label
    }()
    
    private let secondPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.setLetterSpacing()
        return label
    }()
    
    private let starRateView: StarRateView = {
        let view = StarRateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        
        [
            firstPhraseLabel,
            secondPhraseLabel,
            starRateView
        ].forEach {view.addSubview($0)}
        
        setUI()
        setConstraint()
    }
    
    private func setUI() {
        // firstPhraseLabel
        let firstText = "\(postPositionText(tempUserHabit))\n어땠는지 기록해볼까요?"
        firstPhraseLabel.text = firstText
        firstPhraseLabel.halfTextColorChange(fullText: firstText, changeText: postPositionText(tempUserHabit), color: .app_PrimaryColor)
        
        // secondPhraseLabel
        let secondText = "\(tempUserHabit),\n하고나니 기분은 어땠나요?"
        secondPhraseLabel.text = secondText
        secondPhraseLabel.halfTextColorChange(fullText: secondText, changeText: postPositionText(tempUserHabit), color: .app_PrimaryColor)
        
        self.starRateView.isUserInteractionEnabled = true
    }
    
    private func setConstraint() {
        firstPhraseLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(71)
            make.leading.equalToSuperview().offset(32)
        }
        
        starRateView.snp.makeConstraints { make in
            make.top.equalTo(firstPhraseLabel.snp.bottom).offset(44)
//            make.leading.equalToSuperview().offset(59)
            make.centerX.equalToSuperview()
        }
        
        secondPhraseLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(359)
            make.leading.equalTo(firstPhraseLabel)
        }
    }

}
