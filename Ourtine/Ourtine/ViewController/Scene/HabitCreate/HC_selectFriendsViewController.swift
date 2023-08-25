//
//  HC_selectFriendsView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/09.
//

import UIKit

class HabitCreate_selectFriednsViewController: UIViewController {
    
    let HC_selectFreinds_View = HabitCreate_selectFriednsView()
    
    /// 멤버 선택 명수 제한을 위한 변수입니다.
    /// 뷰 로드시 싱글톤에서 데이터를 받아옵니다.
    var memberCountLimit: Int? = nil
    
    // MARK: - HCFlowData에 저장되는 값잆니다.
    var chosenMemberSet = Set<String>() {
        didSet {
            let attributedText = NSMutableAttributedString(string: "\(chosenMemberSet.count) 명 선택 중")
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
        HabitCreateFlowManager.shared.printself()
    }
    
    // 뷰 로딩된 후에 한번만
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 네비게이션 바 보이지 않게
        self.navigationController?.navigationBar.isHidden = true
        
        // 선택 제한 멤버수 불러오기
        self.memberCountLimit = HabitCreateFlowManager.shared.habitInformation.habitMemberNum
        
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
    
    private func getCountLimit() {
        guard let count = HabitCreateFlowManager.shared.habitInformation.habitMemberNum else {
            print("데이터를 불러오지 못했습니다")
            self.navigationController?.popToRootViewController(animated: true)
            return
        }
        self.memberCountLimit = count
    }
    
    /// 해당 페이지의 조건을 만족했는지 확인합니다
    private func checkToGO() {
        
        guard self.chosenMemberSet.count <= 6 && self.chosenMemberSet.count <= memberCountLimit ?? 6  else {
            print("memberCount가 적합한 수가 아닙니다")
            self.HC_selectFreinds_View.nextBtn.isEnabled = false
            return
            
        }
    
        self.HC_selectFreinds_View.nextBtn.isEnabled = true
    }
    
    /// 해당 페이지에서 저장된 데이터를 flowdata로 보내고, 제대로 저장됐는지 확인합니다.
    private func saveToFlowData() -> Bool {
        
        // 습관 생성 플로우의 데이터를 저장
        guard !self.chosenMemberSet.isEmpty else { return false }
        let memberList = self.chosenMemberSet
        HabitCreateFlowManager.shared.habitInformation.habitMemberList = Array(chosenMemberSet)

        // 싱글톤 클래스 객체에 값이 저장되면 넘어가도록 guarding
        guard (HabitCreateFlowManager.shared.habitInformation.habitMemberList != nil ) else {
            print("HabitCreateFlowManager.shared.habitInformation.habitMemberList에 값이 저장되지 않았습니다. 다시 시도해주세요")
            return false
        }

        return true
    }
    
    @objc func nextVC() {
        
        // 데이터 저장 실패 시 push X
        guard saveToFlowData() else { return }
        
        var viewController = UIViewController()
        
        // private 설정일때
        if HabitCreateFlowManager.shared.habitInformation.habitType == .privateType {
            // 친구가 있냐 없냐로 나누어야하는데, API 연결 필요함
            // API 없는 현재는 무조건 친구 없는 경우로 갑니다
            if false { // 친구가 있는 경우
                // 타입 캐스팅
                let finalVC = HabitCreate_finalViewController() as HabitCreate_finalViewController
                finalVC.isPrivate = true
                viewController = finalVC
            }
            else { // 친구가 없는 경우
                viewController = HabitCreate_noFriednsViewController()
            }
        }
        // public 설정일 때
        if HabitCreateFlowManager.shared.habitInformation.habitType == .publicType {
            // 타입 캐스팅
            let finalVC = HabitCreate_finalViewController() as HabitCreate_finalViewController
            finalVC.isPrivate = false
            viewController = finalVC
        }
        
        viewController.hidesBottomBarWhenPushed = true // 탭 바 숨기기 설정
        
        self.navigationController?.pushViewController(viewController, animated: true)
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
       
        return Dummy_memberList.count
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
        //print("눌렀네요 \(indexPath.row)번 셀")
        //self.HC_selectFreinds_View.nextBtn.isEnabled = true
        let cell = collectionView.cellForItem(at: indexPath) as? HC_MemberCollectionViewCell
        cell?.gotChosen.toggle()
        
        if let name = cell?.memberData.name {
            if cell?.gotChosen == true {
                self.chosenMemberSet.insert(name)
                
            } else {
                self.chosenMemberSet.remove(name)
            }
        }
        
        checkToGO()
        
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
