//
//  HC_chooseCategoryViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit

class HabitCreate_chooseCategoryViewController: UIViewController {
    
    let HC_chooseCategory_View = HabitCreate_chooseCategoryView()
    // MARK: - HCFlowData에 저장되는 값잆니다.
    var selectedCategorySet: Set<String> = []
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_chooseCategory_View
        HabitCreateFlowManager.shared.printself()
    }
    
    // 뷰 로딩된 후에 한번만
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 네비게이션 바 보이지 않게
        self.navigationController?.navigationBar.isHidden = true
        
        // MARK: - 다음 버튼의 비활성화
        self.HC_chooseCategory_View.nextBtn.isEnabled = false
        
        //MARK: - categoryCollectionView 파일 register
        self.HC_chooseCategory_View.categoryCollectionView.register(HabitCreateCategoryCVCell.self, forCellWithReuseIdentifier: HabitCreateCategoryCVCell.identifier)
        
        //MARK: - categoryCollectionView 연결
        self.HC_chooseCategory_View.categoryCollectionView.delegate = self
        self.HC_chooseCategory_View.categoryCollectionView.dataSource = self
        
        //MARK: - nextBTN
        self.HC_chooseCategory_View.nextBtn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        //MARK: - backBTN
        //네비게이션 바 버튼은 .addTarget X
        // .action이랑 .target
        self.HC_chooseCategory_View.navigationBar.leftButton.action = #selector(popVC)
        self.HC_chooseCategory_View.navigationBar.leftButton.target = self
    }

    /// 해당 페이지의 조건을 만족했는지 확인합니다
    private func checkToGO() {
        // 선택한 카테고리가 없다면 버튼 비활성화
        if self.selectedCategorySet.isEmpty {
            self.HC_chooseCategory_View.nextBtn.isEnabled = false
        }
        // 카테고리 하나라도 선택했다면 버튼 활성화
        else {
            self.HC_chooseCategory_View.nextBtn.isEnabled = true
        }
    }
    
    /// 해당 페이지에서 저장된 데이터를 flowdata로 보내고, 제대로 저장됐는지 확인합니다.
    private func saveToFlowData() -> Bool {
        
        // 습관 생성 플로우의 데이터를 저장
        let selectedArr = Array(self.selectedCategorySet)
        HabitCreateFlowManager.shared.habitInformation.habitCategory = selectedArr
        
        // 싱글톤 클래스 객체에 값이 저장되면 넘어가도록 guarding
        guard (HabitCreateFlowManager.shared.habitInformation.habitCategory != nil) else {
            print("HabitCreateFlowManager.shared.habitInformation.habitCategory에 값이 저장되지 않았습니다. 다시 시도해주세요")
            return false
        }
        
        return true
    }
    
    /// 버튼 탭했을 때 값 flowdata로 보냅니다
    @objc func nextVC() {
        
        // 데이터 저장 실패 시 push X
        guard saveToFlowData() else { return }
        
        self.navigationController?.pushViewController(HabitCreate_introduceViewController(), animated: true)
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}

/// CollectionView의 Delegate와 DataSource 상속 내용입니다
extension HabitCreate_chooseCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// numberOfItemsInSection : cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return Dummy_HC_Categories.count
    }
    
    /// cellForItemAt : cell 내용 배정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCreateCategoryCVCell.identifier, for: indexPath) as? HabitCreateCategoryCVCell else { return UICollectionViewCell() }
        cell.getCellData(data: Dummy_HC_Categories[indexPath.row])
            return cell
    }
    
    /// didSelectItemAt : cell 선택했을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // memberCollectionView일 때
        //print("눌렀네요 \(indexPath.row)번 셀")
        
        //cell 색 바꾸기
        let cell = collectionView.cellForItem(at: indexPath) as? HabitCreateCategoryCVCell
        cell?.gotChosen.toggle()
        
        // 선택한 카테고리를 리스트에 저장
        if let text = cell?.titleLabel.text {
            if self.selectedCategorySet.contains(text) {
                self.selectedCategorySet.remove(text) // 이미 선택된 경우 삭제
            }
            else {
                self.selectedCategorySet.insert(text) // 선택되지 않은 경우 추가
            }
        }
        
        checkToGO() // 조건확인
    }
}

/// CollectionView의  FlowLayout 상속 내용입니다
extension HabitCreate_chooseCategoryViewController: UICollectionViewDelegateFlowLayout {
    
    // CollectionView의 좌우 여백 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let topBottomPadding: CGFloat = 30
        let leftPadding: CGFloat = 15
        let rightPadding: CGFloat = 15

        return UIEdgeInsets(top: topBottomPadding, left: leftPadding, bottom: 10, right: rightPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.HC_chooseCategory_View.frame.width/2 - 20, height: self.HC_chooseCategory_View.frame.width/4)
    }
    
//    //섹션의 행 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 15
//    }
//
//    //섹션의 열 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
}

import SwiftUI
struct HabitCreate_chooseCategory_ViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_chooseCategoryViewController()
            return ViewController
        }
    }
}
