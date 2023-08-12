//
//  LF_SelectionOfHBViewController.swift
//  Ourtine
//
//  Created by 박민선 on 2023/08/07.
//

import UIKit
import SnapKit


// 셀 조절을 망했습니다

class LF_SelectionOfHBViewController: UIViewController, UICollectionViewDelegate {
    
    var categories: [HC_Category] = []
    
    lazy var navigationBar: Custom_NavigationBar = {
        let nav = Custom_NavigationBar()
        return nav
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "어떤 습관을 들이고 싶어요?"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.text = "2개"
        label.textColor = .app_PrimaryColor
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    lazy var thirdLabel: UILabel = {
        let label = UILabel()
        label.text = "이상 선택해 주세요!"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18.3, weight: .medium)
        return label
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let itemWidth: CGFloat = HabitCreateCategoryCVCell.cellWidth
        let itemHeight: CGFloat = HabitCreateCategoryCVCell.cellHeight
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumInteritemSpacing = 2.0
        flowLayout.minimumLineSpacing = 14.0

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HabitCreateCategoryCVCell.self, forCellWithReuseIdentifier: HabitCreateCategoryCVCell.identifier)
        return collectionView
    }()
    
    let nextBtn: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .app_PrimaryColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setConstraints()
        
        categories = [
            HC_Category("운동"),
            HC_Category("생활습관"),
            HC_Category("독서"),
            HC_Category("스터디"),
            HC_Category("외국어"),
            HC_Category("취미생활"),
            HC_Category("돈관리"),
            HC_Category("커리어")
        ]
        
        self.categoryCollectionView.layer.applyFigmaShadow(
            color: .black,
            alpha: 0.3,
            x: 0,
            y: 2,
            blur: 4,
            spread: 0
        )
        
        self.categoryCollectionView.reloadData()
    }
    
    func addSubviews() {
        [
            navigationBar,
            topLabel,
            secondLabel,
            thirdLabel,
            categoryCollectionView,
            nextBtn
        ].forEach { self.view.addSubview($0) }
    }
    
    func setConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        topLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(30)
        }
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(30)
        }
        
        thirdLabel.snp.makeConstraints {
            $0.leading.equalTo(secondLabel.snp.trailing).offset(3)
            $0.top.equalToSuperview().offset(99.2)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }

        
        nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.95)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
    }
}

extension LF_SelectionOfHBViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCreateCategoryCVCell.identifier, for: indexPath) as! HabitCreateCategoryCVCell
        let category = categories[indexPath.item]
        cell.getCellData(data: category)
        return cell
    }
}

import SwiftUI

@available(iOS 15.0, *)
struct LF_SelectionOfHBViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewController = LF_SelectionOfHBViewController()
            return viewController
        }
    }
}
