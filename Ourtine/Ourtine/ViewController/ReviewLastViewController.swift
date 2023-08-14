//
//  ReviewLastViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/14.
//

import UIKit

class ReviewLastViewController: UIViewController {
    
    var tempUserName = "은지"
    
    var selectedFeelingIndex: Int?
    var selectedStarNumber: Int? = 0
    
    private let phraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.setLetterSpacing()
        return label
    }()
    
    private let feelingImage: UIImageView = {
        let view = UIImageView()
        view.image = getResizedSymbolImage(UIImage(systemName: "questionmark") ?? UIImage(), width: 115, height: 115)
        view.tintColor = .app_PrimaryColor
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let starRateView: StaticStarRateView = {
        let view = StaticStarRateView()
        view.currentStar = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        addSubviews()
        setConstraints()
    }
    
    private func setUI() {
        // phraseLabel
        let wholeText = "\(tempUserName)님\n오늘도 고생하셨어요!"
        phraseLabel.text = wholeText
        phraseLabel.halfTextColorChange(fullText: wholeText, changeText: tempUserName+"님", color: .app_PrimaryColor)
        
        // feelingImage
        let feelingImageIndex = Int(selectedFeelingIndex ?? 0) + 1
        let feelingImageName = "feeling" + "\(feelingImageIndex)"
        print(feelingImageName)
        feelingImage.image = UIImage(named: feelingImageName)
        
        // starRateView
        starRateView.currentStar = selectedStarNumber ?? 0
        
    }
    
    private func addSubviews() {
        [
            phraseLabel,
            feelingImage,
            starRateView
        ].forEach({view.addSubview($0)})
    }
    
    private func setConstraints() {
        phraseLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(71)
            make.centerX.equalToSuperview()
        }
        
        feelingImage.snp.makeConstraints { make in
            make.top.equalTo(phraseLabel.snp.bottom).offset(116)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(116)
        }
        
        starRateView.snp.makeConstraints { make in
            make.top.equalTo(feelingImage.snp.bottom).offset(32.73)
            make.centerX.equalToSuperview()
        }
    }

}

import SwiftUI
struct ReviewLastViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = ReviewLastViewController()
            return ViewController
        }
    }
}
