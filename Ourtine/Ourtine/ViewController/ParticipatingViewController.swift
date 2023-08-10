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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .app_PrimaryColor
        
        [
            habitPhrase,
        ].forEach {view.addSubview($0)}


        // phraseLabel
        let text = "\(tempUserName)님, \(postPositionText(tempUserHabit))\n오늘도 활기차게!"
        habitPhrase.text = text
        habitPhrase.halfTextColorChange(fullText: text, changeText: postPositionText(tempUserHabit))
        
        setConstraints()
    }
    
    private func setConstraints() {
        // habitPhrase
        habitPhrase.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(21.9)
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

