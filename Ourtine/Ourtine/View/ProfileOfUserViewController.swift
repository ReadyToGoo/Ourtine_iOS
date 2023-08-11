//
//  ProfileOfUserViewController.swift
//  Ourtine
//
//  Created by 박민선 on 2023/08/10.
//

import UIKit
import SnapKit

class ProfileOfUserViewController: UIViewController {
    
    lazy var navigationBar: Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    lazy var scrollView: UIScrollView = {
           let scrollView = UIScrollView()
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           return scrollView
       }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "singlePerson")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: 112).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 112).isActive = true
        
        
        return imageView
    }()
    
    
    lazy var followingCountLabel: UILabel = {
        let label = UILabel()
        label.text = "120"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.text = "팔로잉"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var followersCountLabel: UILabel = {
        let label = UILabel()
        label.text = "180"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.text = "팔로워"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var followBtn: UIButton = {
        let button = UIButton()
        button.setTitle("팔로우", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = .app_PrimaryColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        button.widthAnchor.constraint(equalToConstant: 72).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        return button
    }()
    
    lazy var subhead: UILabel = {
        let label = UILabel()
        label.text = "하루의 시작을 활기차게 해보고자 아워틴을 깔게 되었습니다!"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        
        label.widthAnchor.constraint(equalToConstant: 340).isActive = true
        label.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        return label
    }()
    
    lazy var leftframe: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.app_SecondaryColor2.cgColor
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(view)
        
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        return view
    }()
    
    lazy var rightframe: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.app_SecondaryColor2.cgColor
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(view)
        
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        return view
    }()
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.text = "참여율"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        leftframe.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: leftframe.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: leftframe.centerYAnchor).isActive = true
        
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.text = "참여한 습관"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        rightframe.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: rightframe.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: rightframe.centerYAnchor).isActive = true
        
        return label
    }()
    
    lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "98"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .app_PrimaryColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        leftframe.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: leftframe.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: leftframe.bottomAnchor, constant: 17).isActive = true
        
        return label
    }()
    
    lazy var percentageLabel2: UILabel = {
        let label = UILabel()
        label.text = "%"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        leftframe.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: leftframe.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: leftframe.bottomAnchor, constant: 17).isActive = true
        
        return label
    }()
    
    lazy var numberOfHBLabel: UILabel = {
        let label = UILabel()
        label.text = "12"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .app_PrimaryColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        leftframe.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: leftframe.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: leftframe.bottomAnchor, constant: 17).isActive = true
        
        return label
    }()
    
    lazy var numberOfHBLabel2: UILabel = {
        let label = UILabel()
        label.text = "개"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        leftframe.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: leftframe.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: leftframe.bottomAnchor, constant: 17).isActive = true
        
        return label
    }()
    
    lazy var habitOfInterest: UILabel = {
        let label = UILabel()
        label.text = "관심있는 습관"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var participatingHabit: UILabel = {
        let label = UILabel()
        label.text = "참여 중인 습관"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    // 2개 해야해서 carousel말고 collectionView로 하라고 하셨는데 수정하겠습니다
    private lazy var carouselViewController: CarouselViewController = {
        let carouselVC = CarouselViewController()
        carouselVC.view.translatesAutoresizingMaskIntoConstraints = false
        return carouselVC
    }()
    
    lazy var subscribedHabit: UILabel = {
        let label = UILabel()
        label.text = "함께 참여 중인 습관"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        addChild(carouselViewController)
        
        carouselViewController.didMove(toParent: self)
    }
    
    func addSubviews() {
        [
            navigationBar,
            profileImage,
            followingCountLabel,
            followingLabel,
            followersCountLabel,
            followersLabel,
            followBtn,
            subhead,
            leftframe,
            rightframe,
            leftLabel,
            rightLabel,
            percentageLabel,
            percentageLabel2,
            numberOfHBLabel,
            numberOfHBLabel2,
            habitOfInterest,
            participatingHabit,
            (carouselViewController.view),
            subscribedHabit
        ].forEach { self.view.addSubview($0) }

        self.view.addSubview(scrollView)
    }
    
    func setConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        profileImage.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(15)
            $0.width.height.equalTo(100)
        }
        
        
        followingCountLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(37)
            $0.top.equalTo(navigationBar.snp.bottom).offset(35)
            
        }
        
        followingLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(37)
            $0.top.equalTo(followingCountLabel.snp.bottom).offset(2)
        }
        
        followersCountLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(35)
            $0.trailing.equalToSuperview().offset(-80)
            $0.leading.equalTo(followingCountLabel.snp.trailing).offset(42)
            
        }
        
        followersLabel.snp.makeConstraints {
            $0.leading.equalTo(followingLabel.snp.trailing).offset(33)
            $0.top.equalTo(followersCountLabel.snp.bottom).offset(2)
        }
        
        followBtn.snp.makeConstraints {
            $0.width.equalTo(72)
            $0.height.equalTo(32)
            $0.top.equalTo(navigationBar.snp.bottom).offset(35)
            $0.leading.equalTo(followersLabel.snp.leading).offset(66)
        }
        
        subhead.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(37)
            $0.trailing.equalToSuperview().offset(-26)
            $0.top.equalTo(followingLabel.snp.bottom).offset(16)
        }
        
        leftframe.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(72)
            $0.top.equalTo(profileImage.snp.bottom).offset(24)
        }
        
        rightframe.snp.makeConstraints{
            $0.leading.equalTo(leftframe.snp.trailing).offset(50)
            $0.top.equalTo(profileImage.snp.bottom).offset(24)
        }
        leftLabel.snp.makeConstraints{
            $0.top.equalTo(profileImage.snp.bottom).offset(31)
            $0.leading.equalToSuperview().offset(101)
        }
        rightLabel.snp.makeConstraints{
            $0.top.equalTo(profileImage.snp.bottom).offset(31)
            $0.leading.equalTo(leftLabel.snp.leading).offset(137)
        }
        
        percentageLabel.snp.makeConstraints{
            $0.top.equalTo(leftframe.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(91)
        }
        
        percentageLabel2.snp.makeConstraints{
            $0.top.equalTo(leftframe.snp.bottom).offset(22)
            $0.leading.equalTo(percentageLabel.snp.trailing).offset(3)
            $0.lastBaseline.equalTo(percentageLabel)
        }
        
        numberOfHBLabel.snp.makeConstraints{
            $0.leading.equalTo(percentageLabel.snp.leading).offset(152.8)
            $0.top.equalTo(rightframe.snp.bottom).offset(16)
        }
        
        numberOfHBLabel2.snp.makeConstraints{
            $0.leading.equalTo(numberOfHBLabel.snp.trailing).offset(3)
            $0.top.equalTo(rightframe.snp.bottom).offset(22)
        }
        habitOfInterest.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(profileImage.snp.bottom).offset(130)
        }
        
        participatingHabit.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(habitOfInterest.snp.bottom).offset(80)
        }
        
        carouselViewController.view.snp.makeConstraints {
            $0.top.equalTo(participatingHabit.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(152)
        }
        
        subscribedHabit.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(participatingHabit.snp.bottom).offset(198)
        }
    }
}


import SwiftUI

struct ProfileOfUserViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewController = ProfileOfUserViewController()
            return viewController
        }
    }
}
