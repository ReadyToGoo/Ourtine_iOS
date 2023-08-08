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

    // Habit Phrase Label
    private let phraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.setLetterSpacing()
        return label
    }()
    
    private let leftSecond: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "5"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 80, weight: .bold)
        return label
    }()
    
    func startCountDown() {
        var leftTime = 5
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            leftTime -= 1
            
            if leftTime > 0 {
                self.leftSecond.text = String(leftTime)
            } else {
                timer.invalidate()
                self.updateView()
            }
        }
    }
    
    @objc func updateView() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        view.backgroundColor = .orange
        super.viewDidLoad()
        
        [
            phraseLabel,
            leftSecond
        ].forEach {view.addSubview($0)}
        

        // phraseLabel
        let text = "\(tempUserName)님, \n" + "\(postPositionText(tempUserHabit)) 시작해봐요!"
        phraseLabel.text = text
        
        startCountDown()
        setConstraints()
    }
    
    private func setConstraints() {
        // phraseLabel
        phraseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(108.67)
            make.centerX.equalToSuperview()
        }
        
        // leftSecond
        leftSecond.snp.makeConstraints { make in
            make.top.equalTo(phraseLabel.snp.bottom).offset(150.4)
            make.centerX.equalToSuperview()
        }
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

