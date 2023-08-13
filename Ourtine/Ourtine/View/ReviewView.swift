//
//  ReviewView.swift
//  Ourtine
//
//  Created by eunji on 2023/08/13.
//

import UIKit

class ReviewView: UIView {
    
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
    
    // View를 처음 가져올 때 초기화 코드
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        [
            firstPhraseLabel,
            secondPhraseLabel
        ].forEach {addSubview($0)}
        
        setUI()
        setConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        // firstPhraseLabel
        let firstText = "\(postPositionText(tempUserHabit))\n어땠는지 기록해볼까요?"
        firstPhraseLabel.text = firstText
        firstPhraseLabel.halfTextColorChange(fullText: firstText, changeText: postPositionText(tempUserHabit))
        
        // secondPhraseLabel
        let secondText = "\(postPositionText(tempUserHabit))\n하고나니 기분은 어땠나요?"
        firstPhraseLabel.text = secondText
        firstPhraseLabel.halfTextColorChange(fullText: secondText, changeText: postPositionText(tempUserHabit))
    }
    
    private func setConstraint() {
        
    }
}

//import SwiftUI
//struct ReviewView_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewControllerPreview {
//            // Return whatever controller you want to preview
//            let ViewController = ReviewViewController()
//            let navigationController = UINavigationController(rootViewController: ViewController)
//            return navigationController
//        }
//    }
//}
