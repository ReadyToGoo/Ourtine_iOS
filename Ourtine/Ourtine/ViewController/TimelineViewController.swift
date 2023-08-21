//
//  TimelineViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/04.
//

import UIKit
import Kingfisher

class TimelineViewController: UIViewController {
    var timelineProgress: UIView!
    var timeLabels: [UILabel] = []
    var habitImages: [UIImageView] = []

    private let timelineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.35)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .white
        
        return view
    }()
    
//    private let habitImageView: UIImageView {
//
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimeline()
        updateTimeline()
        // 1초마다 타임라인과 시간 레이블 업데이트를 수행
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeline), userInfo: nil, repeats: true)
        setupSubviews()
    }

    
//    private let habitImage: UserProfileImageView = {
//        let imageView = UserProfileImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
//        imageView.image = UIImage(named: "habitBackgroundExample")
//        imageView.layer.cornerRadius = imageView.frame.size.width / 2
//        return imageView
//    }()

    func setupTimeline(_ habitList: data_getTodaysHabit? = nil) {
        let timelineLine = UIView(frame: CGRect(x: 18, y: 58.91, width: 358, height: 4))
        timelineLine.backgroundColor = .orange.withAlphaComponent(0.4)
        view.addSubview(timelineLine)
        
        timelineProgress = UIView(frame: CGRect(x: 18, y: 58.91, width: 358, height: 4))
        timelineProgress.backgroundColor = .orange
        view.addSubview(timelineProgress)
                
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        
        let placeholderImage = createImageWithColor(color: .app_SecondaryColor, size: CGSize(width: 50, height: 50))
        
        let hourStep: CGFloat = 360 / 6.0
        for hour in currentHour - 3...currentHour + 3 {
            var label = UILabel(frame: CGRect(x: -5 + hourStep * CGFloat(hour - (currentHour - 3)), y: 63.91, width: 30, height: 16))
            var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
            
            if (hour == currentHour + 3) {
                label = UILabel(frame: CGRect(x: (-10) + hourStep * CGFloat(hour - (currentHour - 3)), y: 63.91, width: 30, height: 16))
//                imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
                imageView.isHidden = true
            }
            else if (hour == currentHour - 3) {
                label = UILabel(frame: CGRect(x: 15 + hourStep * CGFloat(hour - (currentHour - 3)), y: 63.91, width: 30, height: 16))
//                imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
                imageView.isHidden = true
            } else {
                imageView = UIImageView(frame: CGRect(x: hourStep * CGFloat(hour - (currentHour - 3)), y: 0, width: 28, height: 28))
            }
            
            // 오늘 습관 리스트에서 해당 시간대에 해당하는 첫번째 습관 이미지만 페칭 후 반복문 빠져나갑니다
            if let list = habitList {
                for item in list.today {
                    if hour == Int(item.startTime.prefix(2)) {
                        imageView.kf.setImage(with: URL(string: item.imageUrl), placeholder: placeholderImage)
                        break
                    }
                }
            } else {
                imageView.isHidden = true
            }
            
            label.textColor = .black
            label.textAlignment = .center
            label.text = "\(hour % 24)시" // To handle hours after 24
            label.font = .systemFont(ofSize: 9, weight: .regular)
            view.addSubview(label)
            timeLabels.append(label)
            
            //imageView.image = UIImage(named: "habitBackgroundExample")
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.clipsToBounds = true
            view.addSubview(imageView)
            habitImages.append(imageView)
            
//            if (hour != currentHour + 3) && (hour != currentHour - 3) {
            if (hour > currentHour - 3) && (hour < currentHour + 3) {
                imageView.snp.makeConstraints { make in
                    make.centerX.equalTo(label.frame.midX)
                    make.top.equalTo(label.frame.minY).offset(15.3)
                    make.size.equalTo(28)
                }
            }
        }
    }


    
    @objc func updateTimeline() {
        let currentTime = Calendar.current.component(.hour, from: Date())
        let progress = CGFloat(currentTime) / 24.0
        let timelineWidth = view.frame.width - 100 // 직선의 시작과 끝에 여백을 줍니다.
        timelineProgress.frame.size.width = timelineWidth * progress
        
        for (index, label) in timeLabels.enumerated() {
            label.textColor = (index == currentTime) ? .red : .black
        }
    }
    

    
    private func setupSubviews() {
        view.addSubview(timelineView)
        timelineView.frame = view.bounds
        timelineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


import SwiftUI
struct TimelineViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = TimelineViewController()
            return ViewController
        }
    }
}
