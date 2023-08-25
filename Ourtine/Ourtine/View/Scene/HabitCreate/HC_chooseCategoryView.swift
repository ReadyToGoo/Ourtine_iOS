//
//  HC_chooseCategoryView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit
import SnapKit

class HabitCreate_chooseCategoryView: UIView {
    
    // lazy = 이 친구가 호출될때 생성되는 애
    // 그냥 var로만 선언하게되면 앱을 처음 킬때 얘네를 다불러와요
    lazy var navigationBar : Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    lazy var topLabel : UILabel = {
        let label = UILabel()
        label.text = "습관 카테고리를 선택해볼까요?"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        //collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    lazy var nextBtn: HabitCreateFlowButton = {
        let btn = HabitCreateFlowButton()
        btn.setTitle("다음", for: .normal)
        return btn
    }()
    
    
    /// 뷰 요소 추가 함수
    func addSubviews(){
        [
            navigationBar,
            topLabel,
            categoryCollectionView,
            nextBtn
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
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview() //left.right
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        nextBtn.snp.makeConstraints {
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
struct HabitCreate_chooseCategoryView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_chooseCategoryViewController()
            return ViewController
        }
    }
}
