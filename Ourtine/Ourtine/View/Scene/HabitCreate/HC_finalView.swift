//
//  HC_finalView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/09.
//

import UIKit
import SnapKit

class HabitCreate_finalView: UIView {
    
    lazy var navigationBar : Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    /// 타이틀
    lazy var topLabel : UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "[새벽6시에 잠들기]\n초대장을 발송했어요!")
        attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 0, length: 12))
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    /// 드릴게요 라벨
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "친구가 응답하면 알람을 드릴게요!"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    /// 축하이미지
    lazy var celebrationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo2")
        imageView.layer.shadowColor = UIColor.lightGray.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: 3, height: 2)
        imageView.layer.shadowRadius = 4
//        view.backgroundColor = .app_PrimaryColor2
        return imageView
    }()
    
    
    
    lazy var okBtn: HabitCreateFlowButton = {
        let btn = HabitCreateFlowButton()
        btn.setTitle("네, 알겠어요", for: .normal)
        return btn
    }()
    
    
    /// 뷰 요소 추가 함수
    func addSubviews(){
        [
            navigationBar,
            topLabel,
            celebrationImage,
            bottomLabel,
            okBtn
        ].forEach {self.addSubview($0)}
        
    }
    
    /// 뷰 요소들 위치 잡아준 함수
    func setConstraint() {
        
        navigationBar.snp.makeConstraints {
            $0.top.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        topLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(30)
        }
        
        celebrationImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(300)
        }
        
        bottomLabel.snp.makeConstraints {
            $0.top.equalTo(celebrationImage.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
        }
        
        okBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide ).multipliedBy(0.95)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    // 뷰컨틀롤러의 viewDidLoad()
    //처음에 이 뷰가 호출되었을때, 보여지기 전에 한번 쭉 실행되는 함수 (초기화)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        addSubviews()
        setConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI
struct HabitCreate_finalView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_finalViewController()
            return ViewController
        }
    }
}
