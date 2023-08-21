//
//  HomeViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/07/27.
//

import UIKit
import SnapKit
import Moya
import Kingfisher

class HomeViewController: UIViewController {
    
    // Dummy Data
    let tempUserName = "은지"
    let tempUserHabit = "반려동물 물주기"
    
    // Habit Phrase Label
    ///
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
    private let startBtn: UIButton = {
        let width: CGFloat = 156.56
        let height: CGFloat = 116.72

        let posX: CGFloat = UIScreen.main.bounds.width/2 - width/2
        let posY: CGFloat = UIScreen.main.bounds.height/2 - height/2

        var config = UIButton.Configuration.filled()
        
        // text
        var text = AttributedString.init("참여하기")
        text.font = .systemFont(ofSize: 20.0, weight: .bold)
        text.foregroundColor = .black.withAlphaComponent(1)
        config.attributedTitle = text
        
        // image
        config.image = UIImage(systemName: "play.fill")
        config.imagePadding = 10
        config.imagePlacement = .trailing
        
        // size
        config.buttonSize = .small
        config.contentInsets = NSDirectionalEdgeInsets(top: 19, leading: 30, bottom: 16, trailing: 20)
        
        config.baseBackgroundColor = UIColor(.white).withAlphaComponent(0.6)
        
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 16
        button.layer.applyFigmaShadow(color: .black, alpha: 0.25, x: 0, y: 10, blur: 10, spread: 4)
        
        // action
        button.configurationUpdateHandler = { button in
              var config = button.configuration
              config?.image = button.isHighlighted ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
              button.configuration = config
        }
        
        return button
    }()
    
    // startBtnTapped
    @objc func buttonTapped(_sender: UITapGestureRecognizer) {
        let vc = WaitingViewController()
        self.navigationController?.pushViewController(vc, animated: false)
        print("Move to Starting Habit View")
    }
    
    // timeline
    private lazy var timelineViewController: TimelineViewController = {
        let timelineVC = TimelineViewController()
        timelineVC.view.translatesAutoresizingMaskIntoConstraints = false
        return timelineVC
    }()
    
    
    // carousel
    private lazy var carouselViewController: CarouselViewController = {
        let carouselVC = CarouselViewController()
        carouselVC.view.translatesAutoresizingMaskIntoConstraints = false
        return carouselVC
    }()
    
    private let tempView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.35)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        // addSubview, addChild
        addChild(carouselViewController)
        addChild(timelineViewController)
        
        [
            phraseLabel,
            timeLabel,
            startBtn,
            (carouselViewController.view),
            tempView,
            (timelineViewController.view)
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
        
        //
        timelineViewController.didMove(toParent: self)
        
        fetchData { result in
            self.timelineViewController.setupTimeline(result)
        }
        
    }
    
    private func fetchData(completion: @escaping (data_getTodaysHabit) -> Void) {
        let habitAPI = MoyaWrapper<HabitAPI>(endPointClosure: MoyaProvider.defaultEndpointMapping,
                                             stubClosure: MoyaProvider.immediatelyStub)
        habitAPI.requestSuccessRes(target: .getTodaysHabit, instance: data_getTodaysHabit.self)
        { result in
            switch result {
            case .success(let result) :
                print(result)
                
                completion(result)
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func setConstraints() {
        // phraseLabel
        phraseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(92.16)
            make.leading.equalToSuperview().offset(23.41)
        }

        // timeLabel
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(phraseLabel.snp.bottom).offset(71)
            make.centerX.equalToSuperview()
        }
        
        // startBtn
        startBtn.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(77.63)
            make.centerX.equalToSuperview()
        }
        
        // timeline
        timelineViewController.view.snp.makeConstraints { make in
            make.top.equalTo(startBtn.snp.bottom).offset(32.16)
//            make.height.equalTo(78)
            make.leading.trailing.equalToSuperview()
        }
        
        // carousel
        carouselViewController.view.snp.makeConstraints { make in
//            make.bottom.equalToSuperview().offset(-102.78)
            make.top.equalTo(startBtn.snp.bottom).offset(135.63)
//            make.leading.equalTo(view.snp.leading).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(152)
        }
        
        tempView.snp.makeConstraints { make in
            make.top.equalTo(startBtn.snp.bottom).offset(32.61)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(84.31)
        }
    }
}

// 조사 판단 함수
func postPositionText(_ word: String)->String {
    guard let lastText = word.last else { return word }
    let unicodeVal = UnicodeScalar(String(lastText))?.value
    
    guard let value = unicodeVal else { return word }
    if (value < 0xAC00 || value > 0xD7A3) { return word }
    let last = ( value - 0xAC00 ) % 28
    let str = last > 0 ? "을" : "를"
    
    return word+str
    
}

import SwiftUI
import Moya
struct HomeViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = HomeViewController()
            return ViewController
        }
    }
}

