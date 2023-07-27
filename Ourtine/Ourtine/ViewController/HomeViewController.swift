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
    
    // Habit Phrase View
    private let phraseView: UIView = {
        let phraseView = HomeTextBoxView()
        phraseView.translatesAutoresizingMaskIntoConstraints = false
        phraseView.backgroundColor = .white
        phraseView.size = CGSize(width: 358, height: 79.91)
        
        return phraseView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        // addSubview
        [
            phraseView
        ].forEach {view.addSubview($0)}
        
        // phraseView
        let text = "\(tempUserName), \n" + "\(postPositionText(tempUserHabit)) 시작해보아요!"
        if let phraseView = phraseView as? HomeTextBoxView {
            phraseView.text = text
        }
        
        setConstraints()
    }
    
    private func setConstraints() {
        // phraseView
        phraseView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(62)
            make.centerX.equalToSuperview()
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
