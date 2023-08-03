//
//  HomeViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/07/27.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // Dummy Data
    let tempUserName = "은지"
    let tempUserHabit = "반려동물 물주기"
    
    // Habit Phrase Label
    private let phraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.setLetterSpacing()
        return label
    }()
    
    // TimeLabel
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "00:00:12"
        label.textColor = .white
        label.font = .systemFont(ofSize: 60, weight: .bold)
        label.setLetterSpacing()
        
        return label
    }()
    
    // startBtn
    private let startBtn: UIView = {
        let button = HomeTextBoxView()
        button.text = "시작하기"
        button.size = CGSize(width: 358, height: 60)
        
        return button
    }()
    
    
    // startBtnTapped
    @objc func buttonTapped(_sender: UITapGestureRecognizer) {
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: false)
        print("Move to Starting Habit View")
    }
    
    // carousel
    private lazy var carouselViewController: CarouselViewController = {
        let carouselVC = CarouselViewController()
        carouselVC.view.translatesAutoresizingMaskIntoConstraints = false
        return carouselVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        // addSubview, addChild
        addChild(carouselViewController)
        
        [
            phraseLabel,
            timeLabel,
            startBtn,
            (carouselViewController.view)
        ].forEach {view.addSubview($0)}
        
        // phraseLabel
        let text = "\(tempUserName)님, \n" + "\(postPositionText(tempUserHabit)) 시작해봐요!"

        phraseLabel.text = text
        
        // startBtn
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.buttonTapped(_sender:)))
        startBtn.addGestureRecognizer(tapGestureRecognizer)
        
        setConstraints()
        
        // carousel
        carouselViewController.didMove(toParent: self)
        

    }
    
    
    private func setConstraints() {
        // phraseLabel
        phraseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(92)
            make.leading.equalToSuperview().offset(23.41)
        }

        // timeLabel
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(phraseLabel.snp.bottom).offset(71)
            make.centerX.equalToSuperview()
        }
        
        // startBtn
        startBtn.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(57)
            make.centerX.equalToSuperview()
        }
        
        // carousel
        carouselViewController.view.snp.makeConstraints { make in
            make.top.equalTo(startBtn.snp.bottom).offset(135)
            make.leading.equalTo(view.snp.leading).offset(18)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(152)
        }
        
        
    }
    
    func postPositionText(_ word: String)->String {
        guard let lastText = word.last else { return word }
        let unicodeVal = UnicodeScalar(String(lastText))?.value
        
        guard let value = unicodeVal else { return word }
        if (value < 0xAC00 || value > 0xD7A3) { return word }
        let last = ( value - 0xAC00 ) % 28
        let str = last > 0 ? "을" : "를"
        
        return word+str
        
    }
}

import SwiftUI
struct HomeViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = HomeViewController()
            return ViewController
        }
    }
}
