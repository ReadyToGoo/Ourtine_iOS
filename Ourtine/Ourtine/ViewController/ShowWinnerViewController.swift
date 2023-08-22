//
//  ShowWinnerViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/22.
//

import UIKit
import SnapKit

class ShowWinnerViewController: UIViewController {
    
    private var tempUserName: String = "bunny"
    private var winnerNames: [String] = []
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainPhrase: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .app_SecondaryColor
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.text = "오늘의 습관러는"
        return label
    }()
    
    private let winnersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = ""
        return label
    }()
    
    private let winnerImage: UserProfileImageView = {
        let view = UserProfileImageView(frame: CGRect(x: 0, y: 0, width: 299.03, height: 299.03))
        view.setImage(imageName: "power")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private let encouragePhrase: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = ""
        return label
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black.withAlphaComponent(0.6)
        super.viewDidLoad()
        
        [
            blurEffectView,
            mainPhrase,
            winnersLabel,
            winnerImage,
            encouragePhrase
        ].forEach{view.addSubview($0)}
        
        setUI()
    }
    
    private func setUI() {
        updateWinners()
        updateEncouragePhrase()
        setConstraints()
//        updateView()
    }
    
    private func updateWinners() {
        // TODO: Get winner name by API
        var combinedString = ""
        let winnerName1 = "power"
        winnerNames.append(winnerName1)
        for (index, name) in winnerNames.enumerated() {
            if index == 0 {
                combinedString += "\(name)님"
            } else {
                combinedString += ", \(name)님"
            }
        }
        
        winnersLabel.text = combinedString
    }
    
    private func updateEncouragePhrase() {
        let changeText = "베스트 습관러"
        
        if (winnerNames.contains(tempUserName)) {
            let text = "\(tempUserName)님,\n베스트 습관러로 선정된 것을\n축하드립니다!"
            encouragePhrase.halfTextColorChange(fullText: text, changeText: changeText, color: .app_SecondaryColor)
        } else {
            let text = "\(tempUserName)님, 다음에는\n베스트 습관러가 되어보아요!"
            encouragePhrase.halfTextColorChange(fullText: text, changeText: changeText, color: .app_SecondaryColor)        }
    }
    
    private func setConstraints() {
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainPhrase.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(112)
            make.centerX.equalToSuperview()
        }
        
        winnersLabel.snp.makeConstraints { make in
            make.top.equalTo(mainPhrase.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
        }
        
        winnerImage.snp.makeConstraints { make in
            make.top.equalTo(mainPhrase.snp.bottom).offset(126.48)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(299.03)
        }
        
        encouragePhrase.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-129.59)
            make.centerX.equalToSuperview()
        }
    }
    
    private func updateView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.dismiss(animated: false)
        }
    }
}

import SwiftUI

struct ShowWinnerViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = ShowWinnerViewController()
            return ViewController
        }
    }
}
