//
//  HC_selectFriendsView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/09.
//

import UIKit

class HabitCreate_selectFriednsViewController: UIViewController {
    
    let HC_selectFreinds_View = HabitCreate_selectFriednsView()
    
    var chosenMemberCount: Int = 0 {
        didSet {
            let attributedText = NSMutableAttributedString(string: "\(chosenMemberCount) 명 선택 중")
            attributedText.addAttribute(.foregroundColor, value: UIColor.app_PrimaryColor, range: NSRange(location: 0, length: 2))
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .bold), range: NSRange(location: 0, length: 2))
            attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 2, length: 6))
            self.HC_selectFreinds_View.countLabel.setAttributedTitle(attributedText, for: .normal)
        }
    }
    
    // view 로드할 때 searchView로 가져오기
    override func loadView() {
        super.loadView()
        view = HC_selectFreinds_View
        
    }
    
    // 뷰 로딩된 후에 한번만
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 네비게이션 바 보이지 않게
        self.navigationController?.navigationBar.isHidden = true
        
        // MARK: - 다음 버튼의 비활성화
        self.HC_selectFreinds_View.nextBtn.isEnabled = false
        
        //MARK: - categoryCollectionView 파일 register
        self.HC_selectFreinds_View.categoryCollectionView.register(HC_MemberCollectionViewCell.self, forCellWithReuseIdentifier: HC_MemberCollectionViewCell.identifier)
        
        //MARK: - categoryCollectionView 연결
        self.HC_selectFreinds_View.categoryCollectionView.delegate = self
        self.HC_selectFreinds_View.categoryCollectionView.dataSource = self
        
        //MARK: - nextBTN
        self.HC_selectFreinds_View.nextBtn.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        //MARK: - backBTN
        //네비게이션 바 버튼은 .addTarget X
        // .action이랑 .target
        self.HC_selectFreinds_View.navigationBar.leftButton.action = #selector(popVC)
        self.HC_selectFreinds_View.navigationBar.leftButton.target = self
    }
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(HabitCreate_introduceViewController(), animated: true)
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}

/// CollectionView의 Delegate와 DataSource 상속 내용입니다
extension HabitCreate_selectFriednsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// numberOfItemsInSection : cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return Dummy_HC_Categories.count
    }
    
    /// cellForItemAt : cell 내용 배정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HC_MemberCollectionViewCell.identifier, for: indexPath) as? HC_MemberCollectionViewCell else { return UICollectionViewCell() }

        cell.getMemberData(data: Dummy_memberList[indexPath.row])
        return cell
    }
    
    /// didSelectItemAt : cell 선택했을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // memberCollectionView일 때
        print("눌렀네요 \(indexPath.row)번 셀")
        self.HC_selectFreinds_View.nextBtn.isEnabled = true
        let cell = collectionView.cellForItem(at: indexPath) as? HC_MemberCollectionViewCell
        cell?.gotChosen.toggle()
        if cell?.gotChosen == true {
            chosenMemberCount += 1
        } else { chosenMemberCount -= 1 }
    }
}

/// CollectionView의  FlowLayout 상속 내용입니다
extension HabitCreate_selectFriednsViewController: UICollectionViewDelegateFlowLayout {
    
    // CollectionView의 좌우 여백 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let topBottomPadding: CGFloat = 30
        let leftPadding: CGFloat = 15
        let rightPadding: CGFloat = 15

        return UIEdgeInsets(top: topBottomPadding, left: leftPadding, bottom: 10, right: rightPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.HC_selectFreinds_View.frame.width/3 - 20, height: self.HC_selectFreinds_View.frame.width/4)
    }
    
    //섹션의 행 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    //섹션의 열 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

import SwiftUI
struct HabitCreate_selectFriednsViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitCreate_selectFriednsViewController()
            return ViewController
        }
    }
}
