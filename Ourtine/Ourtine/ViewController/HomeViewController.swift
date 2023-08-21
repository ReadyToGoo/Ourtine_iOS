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
    
    var topHabitId: Int?
    var currentHabitIndex: Int?
    var habitTime: String = "00:00:00" {
        didSet {
            self.timeLabel.text = self.habitTime
        }
    }
    
    var remainingTimeInSeconds:Int = -1 //초로 된 남은 시간
    var timer: Timer?
    
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
    
    lazy var topBox: UIView = {
        let view = UIView()
        view.backgroundColor = .app_BrightnessColor0.withAlphaComponent(0.8)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var topBoxDateBtn: UIButton = {
        let btn = UIButton()
        btn.tintColor = .app_BrightnessColor60
        btn.setImage(UIImage(systemName: "calendar")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.setTitle(" 08/15~08/22", for: .normal)
        btn.setTitleColor(.app_BrightnessColor40, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        return btn
    }()
    
    lazy var topBoxText: UILabel = {
        let label = UILabel()
        label.text = "이번 주는 매일 미라클 모닝 후 책을 읽을거에요!\n이번 주 까지 책 두권을 읽는게 목표입니다!"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var habitBox: UIView = {
        let view = UIView()
        view.backgroundColor = .app_BrightnessColor0.withAlphaComponent(0.4)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var habitBoxImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .app_SecondaryColor2
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var habitBoxLabel: UILabel = {
        let label = UILabel()
        label.text = "반려식물 물주기"
        label.textColor = UIColor.app_BrightnessColor80
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    // TimeLabel
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "00:00:00"
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
            config?.image = button.isHighlighted ? UIImage(named: "Union") :  UIImage(named: "Union")
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
    
    private let backGroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background2")!
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        let backView = UIView()
        let imageView = UIImageView(image: UIImage(named: "background2"))
        backView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view = backView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        // addSubview, addChild
        addChild(carouselViewController)
        addChild(timelineViewController)
        
        [
//            backGroundImage,
//            phraseLabel,
            topBox,
            topBoxDateBtn,
            topBoxText,
            habitBox,
            habitBoxImage,
            habitBoxLabel,
            timeLabel,
            startBtn,
            (carouselViewController.view),
            tempView,
            (timelineViewController.view)
        ].forEach {view.addSubview($0)}
        
        // phraseLabel
//        let text = "\(tempUserName)님, \n" + "\(postPositionText(tempUserHabit)) 시작해봐요!"
//
//        phraseLabel.text = text
        
        // startBtn
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.buttonTapped(_sender:)))
        startBtn.addGestureRecognizer(tapGestureRecognizer)
        
        setConstraints()
        
        // carousel
        carouselViewController.didMove(toParent: self)
        
        //
        timelineViewController.didMove(toParent: self)
        
        fetchData { result in
//            self.timelineViewController.setupTimeline(result)
//            for item result
//            self.carouselViewController.items = result
//            self.currentHabitIndex = self.getTodaysClosestHabit(list: result)
            let index = self.getTodaysClosestHabit(list: result)
            self.habitBoxImage.kf.setImage(with: URL(string: result.today[index ?? 0].imageUrl))
            self.habitBoxLabel.text = result.today[index ?? 0].title
            self.topBoxText.text = result.userWeeklyLogContents
            
            self.startTimer()
//            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
                                         
//            self.updateTimeLabel(list: result)
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
                self.timelineViewController.setupTimeline(result)
                
                for item in result.today {
                    self.carouselViewController.items.append(CarouselItem(image: item.imageUrl, title: item.title, badgeNum: item.mvp, habitId: item.habitId, participateRate: item.participationRate))
                }
                self.carouselViewController.collectionView.reloadData()
                
                completion(result)
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
                    
    
                                         
    func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
        
    @objc func updateTimer() {
            if remainingTimeInSeconds > 0 {
                remainingTimeInSeconds -= 1
                timeLabel.text = self.calculateSecondsToLabelType(targetTime: self.remainingTimeInSeconds)
                
                if remainingTimeInSeconds > 600 {
                    self.startBtn.titleLabel?.text = "대기 중"
//                    self.startBtn.setImage(nil, for: .normal)
                    self.startBtn.isEnabled = false
                } else {
                    self.startBtn.titleLabel?.text = "참여하기"
//                    self.startBtn.setImage(nil, for: .normal)
                    self.startBtn.isEnabled = true
                }
            } else {
                timer?.invalidate()
                timeLabel.text = "습관에 입장해주세요!"
                timeLabel.font = .systemFont(ofSize: 30, weight: .bold)
            }
    }
    
    /// 제일 빠른 습관 인덱스 찾기
    private func getTodaysClosestHabit(list:data_getTodaysHabit) -> Int? {
        var leftTimeList:[Int] = []
        
        for item in list.today {
            let leftTime = calculateRemainingSeconds(targetTime: item.startTime)
            print(leftTime ?? 9999999)
            leftTimeList.append(leftTime ?? 9999999)
        }
        
        if let minIndex = leftTimeList.enumerated().filter({ $0.element >= 0 }).min(by: { $0.element < $1.element })?.offset {
            print("제일 빠른 습관 인덱스: \(minIndex)")
            self.remainingTimeInSeconds = leftTimeList[minIndex]
            self.habitTime = calculateSecondsToLabelType(targetTime: leftTimeList[minIndex])
            return minIndex
        } else {
            print("배열이 비어있거나 유효한 최소값이 없음")
            return nil
        }
        
    }
    
    // 남은 시간 현재 시간과 계산 -> 초로 리턴
    private func calculateRemainingSeconds(targetTime: String) -> Int? {
        
        let format = DateFormatter()
        format.dateFormat = "HH:mm:ss"
                
        guard let startTime = format.date(from: format.string(from: Date())) else {return nil}
        guard let endTime = format.date(from: targetTime) else {return nil}

        var useTime = Int(endTime.timeIntervalSince(startTime))
        return useTime
    }
    
    // 초로 계산된 시간 hh:mm:ss로 계산
    private func calculateSecondsToLabelType(targetTime: Int) -> String {
        let totalSeconds = targetTime
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
            
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func setConstraints() {
        // phraseLabel
//        phraseLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(92.16)
//            make.leading.equalToSuperview().offset(23.41)
//        }
        
        topBox.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
            $0.bottom.equalTo(topBoxText.snp.bottom).offset(10)
        }
        
        topBoxDateBtn.snp.makeConstraints {
            $0.top.equalTo(topBox).offset(8)
            $0.leading.equalTo(topBox).offset(12)
        }
        
        topBoxText.snp.makeConstraints {
            $0.top.equalTo(topBoxDateBtn.snp.bottom).offset(10)
            $0.leading.equalTo(topBox).offset(12)
            $0.trailing.equalTo(topBox).offset(-12)
        }
        
        habitBox.snp.makeConstraints {
            $0.top.equalTo(topBox.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(topBox)
            $0.height.equalTo(40)
        }
        
        habitBoxImage.snp.makeConstraints {
            $0.leading.equalTo(habitBox.snp.leading).offset(10)
            $0.centerY.equalTo(habitBox)
            $0.size.equalTo(30)
        }
        
        habitBoxLabel.snp.makeConstraints {
            $0.leading.equalTo(habitBoxImage.snp.trailing).offset(10)
            $0.centerY.equalTo(habitBoxImage)
        }
        

        // timeLabel
        timeLabel.snp.makeConstraints { make in
//            make.top.equalTo(habitBox.snp.bottom).offset(71)
            make.centerY.equalToSuperview().offset(-120)
            make.centerX.equalToSuperview()
        }
        
        // startBtn
        startBtn.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(65)
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

