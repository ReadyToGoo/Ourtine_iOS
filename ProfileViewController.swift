//
//  ProfileViewController.swift
//  Ourtine
//
//  Created by 박민선 on 2023/07/28.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    
    // 사용자가 클릭한 카테고리명을 저장할 변수
    private var selectedCategory: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // MARK: - 네비게이션 바 설정
        setupNavigationBar()
        setupUIElements()
    }
    
    private func setupNavigationBar() {
        // button_뒤로가기
        let backButton = UIBarButtonItem(image: UIImage(named: "back_arrow"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .gray
        navigationItem.leftBarButtonItem = backButton
        
        // button_더보기
        let moreButton = UIBarButtonItem(image: UIImage(named: "more_icon"), style: .plain, target: self, action: #selector(moreButtonTapped))
        moreButton.tintColor = .gray
        navigationItem.rightBarButtonItem = moreButton
    }
    
    
    
    @objc private func backButtonTapped() {
        // 뒤로가기 버튼 동작처리
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func moreButtonTapped() {
        // 더보기 버튼 동작처리
    }
    
    // MARK : - UILabel + imageView
    private func setupUIElements() {
        // UILabel_습관명
        let labelHabitName = UILabel()
        labelHabitName.frame = CGRect(x: 0, y: 0, width: 176, height: 40)
        labelHabitName.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelHabitName.font = UIFont.boldSystemFont(ofSize: 30)
        labelHabitName.numberOfLines = 0
        let attributedString = NSMutableAttributedString(string: "[습관명]", attributes: [NSAttributedString.Key.kern: 0.15])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        labelHabitName.attributedText = attributedString
        
        let parent = self.view!
        parent.addSubview(labelHabitName)
        labelHabitName.translatesAutoresizingMaskIntoConstraints = false
        labelHabitName.widthAnchor.constraint(equalToConstant: 176).isActive = true
        labelHabitName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelHabitName.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 10).isActive = true
        labelHabitName.topAnchor.constraint(equalTo: parent.topAnchor, constant: 89).isActive = true
        
        
        // UILabel_해시태그
        let labelHash = UILabel()
        labelHash.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelHash.font = UIFont.systemFont(ofSize: 17)
        labelHash.textAlignment = .left
        let attributedString2 = NSMutableAttributedString(string: "#생산적인 #활동적인")
        attributedString2.addAttribute(.kern, value: 0.005, range: NSRange(location: 0, length: attributedString2.length))
        let paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.lineSpacing = 20
        attributedString2.addAttribute(.paragraphStyle, value: paragraphStyle2, range: NSRange(location: 0, length: attributedString2.length))
        labelHash.attributedText = attributedString2
        labelHabitName.addSubview(labelHash)
        labelHash.translatesAutoresizingMaskIntoConstraints = false
        labelHash.widthAnchor.constraint(equalToConstant: 154).isActive = true
        labelHash.heightAnchor.constraint(equalToConstant: 16).isActive = true
        labelHash.leadingAnchor.constraint(equalTo: labelHabitName.leadingAnchor, constant: 1).isActive = true
        labelHash.centerXAnchor.constraint(equalTo: labelHabitName.centerXAnchor).isActive = true
        labelHash.topAnchor.constraint(equalTo: labelHabitName.bottomAnchor, constant: 11).isActive = true
        
        // MARK: - UILabel_카테고리
        let categoryLabel = UILabel()
        categoryLabel.textColor = .white
        categoryLabel.font = .systemFont(ofSize: 15)
        categoryLabel.text = "카테고리"
        categoryLabel.backgroundColor = UIColor(red: 0.384, green: 0.494, blue: 0.965, alpha: 1)
        categoryLabel.layer.cornerRadius = 8
        categoryLabel.clipsToBounds = true
        categoryLabel.textAlignment = .center
        view.addSubview(categoryLabel)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: labelHash.bottomAnchor, constant: 11).isActive = true
        categoryLabel.widthAnchor.constraint(equalToConstant: 103).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        // MARK: - UIImageView
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 214).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 394).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        // 이미지 설정 함수 호출 (카테고리에 따라 이미지 변경)
        setImageForCategory(selectedCategory)
    }
    
    func didSelectCell(category: String) {
        selectedCategory = category
        updateCategoryView() // 카테고리 뷰 업데이트
    }
    
    private func updateCategoryView() {
        // 카테고리 뷰 업데이트 로직
    }
    
    private func setImageForCategory(_ category: String) {
        let imageView = UIImageView() // imageView 변수를 함수 내부에서 선언
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 214).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 394).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        if category == "카테고리1" {
            let image = UIImage(named: "category1_image")
            imageView.image = image
        }
        else if category == "카테고리2" {
            let image = UIImage(named: "category2_image")
            imageView.image = image
        }
        
        // MARK: - UILabel_참여율 & 만족도
        // 1. 참여율
        let participation = UILabel()
        participation.textColor = .black
        participation.font = .systemFont(ofSize: 15)
        participation.text = "참여율"
        participation.textAlignment = .center
        view.addSubview(participation)
        
        participation.translatesAutoresizingMaskIntoConstraints = false
        participation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38).isActive = true
        participation.topAnchor.constraint(equalTo: view.topAnchor, constant: 407).isActive = true
        participation.widthAnchor.constraint(equalToConstant: 88).isActive = true
        participation.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        var participationPercentage: Double = 50.0
        
        let paricipationPer = UILabel()
        paricipationPer.textColor = .black
        paricipationPer.font = .systemFont(ofSize: 30, weight: .medium)
        paricipationPer.textAlignment = .center
        paricipationPer.text = String(format: "%.0f%%", participationPercentage)
        
        view.addSubview(paricipationPer)
        
        paricipationPer.translatesAutoresizingMaskIntoConstraints = false
        paricipationPer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        paricipationPer.topAnchor.constraint(equalTo: view.topAnchor, constant: 440).isActive = true
        paricipationPer.widthAnchor.constraint(equalToConstant: 88).isActive = true
        paricipationPer.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        
        // 구분선
        let blackLine = UIView()
        blackLine.backgroundColor = .black
        
        view.addSubview(blackLine)
        
        blackLine.translatesAutoresizingMaskIntoConstraints = false
        blackLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 193).isActive = true
        blackLine.topAnchor.constraint(equalTo: view.topAnchor, constant: 395).isActive = true
        blackLine.widthAnchor.constraint(equalToConstant: 1).isActive = true
        blackLine.heightAnchor.constraint(equalToConstant: 95).isActive = true
        blackLine.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/1)   // 회전 각도 설정 (수직으로)
        
        // 2. 만족도
        let satisfaction = UILabel()
        satisfaction.textColor = .black
        satisfaction.font = .systemFont(ofSize: 15)
        satisfaction.text = "만족도"
        satisfaction.textAlignment = .center
        view.addSubview(satisfaction)
        
        satisfaction.translatesAutoresizingMaskIntoConstraints = false
        satisfaction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 246).isActive = true
        satisfaction.topAnchor.constraint(equalTo: view.topAnchor, constant: 407).isActive = true
        satisfaction.widthAnchor.constraint(equalToConstant: 88).isActive = true
        satisfaction.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        let rating: Double = 4.5
        
        let ratingLabel = UILabel()
        ratingLabel.textColor = .black
        ratingLabel.font = .systemFont(ofSize: 30)
        ratingLabel.textAlignment = .center
        
        // 평점이 변경될 때마다 해당 레이블의 텍스트를 업데이트하도록 설정
        ratingLabel.text = String(format: "%.1f", rating)
        
        view.addSubview(ratingLabel)
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 246).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 440).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 88).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        
        // MARK: - 참여인원 프로필 구현
        let participantLabel = UILabel()
        participantLabel.textColor = .black
        participantLabel.font = .systemFont(ofSize: 15)
        participantLabel.text = "참여인원"
        participantLabel.textAlignment = .left
        view.addSubview(participantLabel)
        
        participantLabel.translatesAutoresizingMaskIntoConstraints = false
        participantLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14).isActive = true
        participantLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 520).isActive = true
        participantLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        participantLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        // 참여인원 프로필 view
        let rectangleView = UIView()
        rectangleView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        view.addSubview(rectangleView)
        
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 546).isActive = true
        rectangleView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rectangleView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        rectangleView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        // 사용자 프로필 사진의 원형 마스크 처리를 위한 함수
        func applyCircularMask(to view: UIView) {
            let circleMaskPath = UIBezierPath(ovalIn: view.bounds)
            let maskLayer = CAShapeLayer()
            maskLayer.path = circleMaskPath.cgPath
            view.layer.mask = maskLayer
        }
        
        // MARK: - UIScrollView_프로필사진
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 560).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 82).isActive = true
        
        // 여러 개의 프로필 사진을 가로로 나열하여 스크롤이 가능하도록 추가
        let profileImageSize: CGFloat = 82
        let spacing: CGFloat = 10
        var offsetX: CGFloat = 0
        
        for _ in 1...10 {
            let userProfile = UIImageView()
            userProfile.image = UIImage(named: "user_profile_image") // 여기에 프로필 사진 이미지 설정
            scrollView.addSubview(userProfile)
            
            userProfile.translatesAutoresizingMaskIntoConstraints = false
            userProfile.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: offsetX).isActive = true
            userProfile.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            userProfile.widthAnchor.constraint(equalToConstant: profileImageSize).isActive = true
            userProfile.heightAnchor.constraint(equalToConstant: profileImageSize).isActive = true
            
            // 프로필 사진을 원형으로 마스크 처리
            applyCircularMask(to: userProfile)
            
            offsetX += (profileImageSize + spacing)
        }
        
        // 스크롤 가능 영역 설정
        scrollView.contentSize = CGSize(width: offsetX, height: profileImageSize)
        
        
        // MARK: - UIButton_참여하기
        let participateButton = UIButton()
        participateButton.setTitle("참여하기", for: .normal)
        participateButton.setTitleColor(.white, for: .normal)
        participateButton.titleLabel?.font = .systemFont(ofSize: 15)
        participateButton.backgroundColor = UIColor(red: 0.384, green: 0.494, blue: 0.965, alpha: 1)
        participateButton.layer.cornerRadius = 8
        view.addSubview(participateButton)
        
        participateButton.translatesAutoresizingMaskIntoConstraints = false
        participateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        participateButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 710).isActive = true
        participateButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
        participateButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        // 패딩 값 추가
        participateButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
}


import SwiftUI
struct ProfileViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = ProfileViewController()
            return ViewController
        }
        .previewLayout(.fixed(width: screenWidth, height: screenHeight/2))
    }
}
