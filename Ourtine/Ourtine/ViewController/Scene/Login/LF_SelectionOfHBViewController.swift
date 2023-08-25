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
    
    var selectedCategorySet: Set<String> = []
    
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
        let itemWidth: CGFloat = self.view.frame.width/2 - 20
        let itemHeight: CGFloat = 100
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 15
        
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
        self.view.backgroundColor = .white
        
        self.view.backgroundColor = .white
        SignUpFlowManager.shared.printself()
        nextBtn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        
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
    
    /// 해당 페이지에서 저장된 데이터를 flowdata로 보내고, 제대로 저장됐는지 확인합니다.
    private func saveToFlowData() -> Bool {
        
        // 회원가입 플로우의 데이터를 저장
        let selectedArr = Array(self.selectedCategorySet)
        SignUpFlowManager.shared.signUpInformation.habitCategory = selectedArr
        
        // 싱글톤 클래스 객체에 값이 저장되면 넘어가도록 guarding
        guard (SignUpFlowManager.shared.signUpInformation.habitCategory != nil) else {
            print("SignUpFlowManager.shared.signUpInformation.habitCategory에 값이 저장되지 않았습니다. 다시 시도해주세요")
            return false
        }
        
        print("저장 성공")
        return true
    }
    
    @objc private func nextBtnTapped(_ sender: UIButton) {
        // 코드
        // 데이터 저장 실패 시 push X
        guard saveToFlowData() else { return }
        
        let viewController = LF_DajimViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
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
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(326)
            make.height.equalTo(54)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //cell 색 바꾸기
        let cell = collectionView.cellForItem(at: indexPath) as? HabitCreateCategoryCVCell
        cell?.gotChosen.toggle()
        
        // 선택한 카테고리를 리스트에 저장
        if let text = cell?.titleLabel.text {
            let value = categoryValueFromCellText(text: text)
            if self.selectedCategorySet.contains(value) {
                self.selectedCategorySet.remove(value) // 이미 선택된 경우 삭제
            }
            else {
                self.selectedCategorySet.insert(value) // 선택되지 않은 경우 추가
            }
        }
        
    }
    
    func categoryValueFromCellText(text: String) -> String {
        switch text {
        case "운동" :
            return "EXERCISE"
        case "생활습관" :
            return "LIFESTYLE"
        case "독서" :
            return "READING"
        case "스터디" :
            return "STUDY"
        case "외국어" :
            return "LANGUAGE"
        case "취미생활" :
            return "HOBBY"
        case "돈관리" :
            return "MONEY"
        case "커리어" :
            return "CAREER"
        default :
            return "noValue"
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
