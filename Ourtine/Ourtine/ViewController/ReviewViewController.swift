//
//  ReviewViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/14.
//

import UIKit

class ReviewViewController: UIViewController {
    
    let tempUserHabit = "반려식물 물주기"
    
    var selectedStarNumber: Int? = 0 {
        didSet {
            updateNextBtnState()
        }
    }
    var selectedFeelingIndex: Int? {
        didSet {
            updateNextBtnState()
        }
    }
    
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
    
    private let feelingView: FeelingSelectView = {
        let view = FeelingSelectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nextBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .app_PrimaryColor
        config.background.cornerRadius = 8
        config.contentInsets = NSDirectionalEdgeInsets(top: 17.5, leading: 149, bottom: 17.5, trailing: 149)
        
        var titleAttr = AttributedString.init("다음")
        titleAttr.font = .systemFont(ofSize: 16, weight: .semibold)
        config.attributedTitle = titleAttr
        
        let button = UIButton(configuration: config)
        button.isEnabled = false
        return button
    }()
    
    @objc private func nextBtnTapped() {
        // TODO: Save selectedStarNumber
        // TODO: Save selectedFeelingIndex
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        
        [
            firstPhraseLabel,
            secondPhraseLabel,
            starRateView,
            feelingView,
            nextBtn
        ].forEach {view.addSubview($0)}
        
        setUI()
        setConstraint()
        
        starRateView.delegate = self
        feelingView.delegate = self
    }
    
    private func setUI() {
        // firstPhraseLabel
        let firstText = "\(tempUserHabit),\n어땠는지 기록해볼까요?"
        firstPhraseLabel.text = firstText
        firstPhraseLabel.halfTextColorChange(fullText: firstText, changeText: tempUserHabit, color: .app_PrimaryColor)
        
        // secondPhraseLabel
        let secondText = "\(tempUserHabit),\n하고나니 기분은 어땠나요?"
        secondPhraseLabel.text = secondText
        secondPhraseLabel.halfTextColorChange(fullText: secondText, changeText: tempUserHabit, color: .app_PrimaryColor)
        
        self.starRateView.isUserInteractionEnabled = true
        self.feelingView.isUserInteractionEnabled = true
        
        nextBtn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        
    }
    
    private func updateNextBtnState() {
           nextBtn.isEnabled = selectedStarNumber != 0 && selectedFeelingIndex != nil
       }
    
    private func setConstraint() {
        firstPhraseLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(71)
            make.leading.equalToSuperview().offset(32)
        }
        
        starRateView.snp.makeConstraints { make in
            make.top.equalTo(firstPhraseLabel.snp.bottom).offset(44)
            make.centerX.equalToSuperview()
        }
        
        secondPhraseLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(359)
            make.leading.equalTo(firstPhraseLabel)
        }
        
        feelingView.snp.makeConstraints { make in
            make.top.equalTo(secondPhraseLabel.snp.bottom).offset(44)
            make.centerX.equalToSuperview()
            make.height.equalTo(68)
        }
        
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32)
        }
    }

}

extension ReviewViewController: StarRateViewDelegate {
    func starRateView(_ starRateView: StarRateView, didSelectRating rating: Int) {
        selectedStarNumber = rating
    }
}

extension ReviewViewController: FeelingSelectViewDelegate {
    func feelingSelectView(_ feelingSelectView: FeelingSelectView, didSelectFeelingIndex index: Int) {
        selectedFeelingIndex = index
    }
}

