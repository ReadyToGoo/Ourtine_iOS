//
//  HabitDiscoverViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/26.
//

import UIKit
import SnapKit

/// 습관 탐색 메인 페이지 뷰 컨트롤러입니다.
/// AppTabBarController -> HabitDiscoverViewController
class HabitDiscoverViewController: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate {
    
    // habitSegment를 위한 데이터
    var habitSegmentCV_data: [String] = []
    var habitSegmentCV_selectedCellIndexPath: IndexPath?
    
    // habitProfileView 등록
    lazy var habitProfileScrollView = HabitDiscoverScrollView()
    
    // view 로드할 때 habitProfileView로 가져오기
    override func loadView() {
        super.loadView()
        //view = habitProfileScrollView
        view.backgroundColor = .white
        view.addSubview(habitProfileScrollView)
        
        habitProfileScrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    // 상단 서치바 누르면 검색창으로 이동
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let nextVC = SearchViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 네비게이션 바 보이지 않게
        self.navigationController?.navigationBar.isHidden = true
        
        // 위로 가기 버튼 보이지 않게
        self.habitProfileScrollView.habitProfileView.scrollResetBtn.isHidden = true
        
        // 스크롤뷰 delegate 위임 / 안 쓸 듯
        self.habitProfileScrollView.delegate = self
        
        //MARK: - topBar의 searchBar 연결
        self.habitProfileScrollView.habitProfileView.topBar.searchBar.delegate = self
        
        //MARK: - memberTableViewCell 파일 register
        self.habitProfileScrollView.habitProfileView.memberCollectionView.register(MemberCollectionViewCell.self, forCellWithReuseIdentifier: MemberCollectionViewCell.identifier)
        
        //MARK: - habitSegmentCollectionViewCell 파일 register
        self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.register(HorizontalPickerViewCell.self, forCellWithReuseIdentifier: HorizontalPickerViewCell.identifier)
        
        //MARK: - habitCardCollectionView 파일 register
        self.habitProfileScrollView.habitProfileView.habitCardCollectionView.register(HabitCardCollectionViewCell.self, forCellWithReuseIdentifier: HabitCardCollectionViewCell.identifier)
        
        //MARK: - memberCollectionView 연결
        self.habitProfileScrollView.habitProfileView.memberCollectionView.delegate = self
        self.habitProfileScrollView.habitProfileView.memberCollectionView.dataSource = self
        
        //MARK: - habitSegmentCollectionView 연결
        self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.dataSource = self
        self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.delegate = self
        
        //MARK: - habitCardCollectionView 연결
        self.habitProfileScrollView.habitProfileView.habitCardCollectionView.dataSource = self
        self.habitProfileScrollView.habitProfileView.habitCardCollectionView.delegate = self
        
        //MARK: - habitSegmentCollectionView 초기 설정
        setUp_habitCV_Data()
        DispatchQueue.main.async {
            self.habitCV_select(row: 0)
        }
        
        //MARK: - backBTN
        self.habitProfileScrollView.habitProfileView.topBar.alarmButton.action = #selector(pushVC)
        self.habitProfileScrollView.habitProfileView.topBar.alarmButton.target = self
        
        // MARK: - 위로가기 버튼
        self.habitProfileScrollView.habitProfileView.scrollResetBtn.addTarget(self, action: #selector(tappedResetBtn), for: .touchDown)
        
    }
    
    // 화면 푸시
    @objc func pushVC() {
        self.navigationController?.pushViewController(HabitAlarmViewController(), animated: true)
    }
    
    /// habitSegmentCV의 데이터를 페칭합니다.
    private func setUp_habitCV_Data() {
        for habit in Dummy_habitCategories {
            habitSegmentCV_data.append(habit.name)
        }
    }
    
    // 위로 가기 버튼 눌렀을 때 활성화됩니다.
    @objc func tappedResetBtn() {
        self.habitProfileScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.habitProfileScrollView.habitProfileView.scrollResetBtn.isHidden = true
    }
    
    // 최초 Y좌표는 지정값이 아닌 계산된 동적값이어야 합니다 추후 수정필요
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.habitProfileScrollView {
            // collectionView의 초기 Y 좌표를 설정합니다.
            let habitCV_initialYPosition: CGFloat = 190 //(self.habitCV_Y ?? 180) + 10
            // 스크롤된 거리를 계산합니다.
            let yOffset = scrollView.contentOffset.y
            
            if yOffset > 0 {
                self.habitProfileScrollView.habitProfileView.topBar.frame.origin.y = yOffset
            } else {
                self.habitProfileScrollView.habitProfileView.topBar.frame.origin.y = 0
            }
        
            // collectionView가 상단에 고정되어야 하는 지점까지 스크롤 되었을 때, 상단에 고정시킵니다.
            // 이때 yOffset과
            if yOffset > habitCV_initialYPosition - self.habitProfileScrollView.habitProfileView.topBar.bounds.height {
                self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.frame.origin.y = yOffset + self.habitProfileScrollView.habitProfileView.topBar.bounds.height
                self.habitProfileScrollView.habitProfileView.scrollResetBtn.frame.origin.y = yOffset + screenHeight * 0.8 - 20
                self.habitProfileScrollView.habitProfileView.scrollResetBtn.isHidden = false
                } else {
                    // 초기 위치보다 위로 스크롤 되었을 때는 초기 위치로 이동시킵니다.
                    self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.frame.origin.y = habitCV_initialYPosition
                    
                    self.habitProfileScrollView.habitProfileView.scrollResetBtn.isHidden = true
                }
            }
        }
}

/// CollectionView의 Delegate와 DataSource 상속 내용입니다
extension HabitDiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// numberOfItemsInSection : cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // memberCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.memberCollectionView {
            return Dummy_memberList.count
        }
        // habitSegmentCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView {
            return habitSegmentCV_data.count
        }
        // habitCardCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitCardCollectionView {
            return Dummy_habitCards.count
        }
        // 예외 상황
        return 0
    }
    
    /// cellForItemAt : cell 내용 배정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // memberCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.memberCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.identifier, for: indexPath) as? MemberCollectionViewCell else { return UICollectionViewCell() }
            cell.getMemberData(data: Dummy_memberList[indexPath.row])
            return cell
        }
        // habitSegmentCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HorizontalPickerViewCell.identifier,
                for: indexPath
            ) as? HorizontalPickerViewCell else { return UICollectionViewCell() }
            
            if indexPath == self.habitSegmentCV_selectedCellIndexPath {
                cell.configure(with: habitSegmentCV_data[indexPath.row], isSelected: true)
            }
            else {
                cell.configure(with: habitSegmentCV_data[indexPath.row])
            }
            return cell
        }
        // habitCardCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitCardCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HabitCardCollectionViewCell.identifier,
                for: indexPath
            ) as? HabitCardCollectionViewCell else { return UICollectionViewCell() }
            cell.getHabitsData(data: Dummy_habitCards[indexPath.row])
            return cell
        }
        // 예외 상황
        return UICollectionViewCell()
    }
    
    /// didSelectItemAt : cell 선택했을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // memberCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.memberCollectionView {
            // 멤버 셀 눌렀을 때 동작
            print("member \(indexPath.row) selected")
        }
        // habitSegmentCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView {
            habitCV_select(row: indexPath.row)
        }
        // habitCardCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitCardCollectionView {
            // 습관 카드 셀 눌렀을 때 동작
            print("habit card \(indexPath.row) selected")
        }
        
        
    }
}

/// CollectionView의  FlowLayout 상속 내용입니다
extension HabitDiscoverViewController: UICollectionViewDelegateFlowLayout {
    
    // CollectionView들의 좌우 여백 조정
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            var topBottomPadding: CGFloat = 0
            var leftPadding: CGFloat = 10
            var rightPadding: CGFloat = 10
            
            if collectionView == self.habitProfileScrollView.habitProfileView.habitCardCollectionView {
                topBottomPadding = 10
                leftPadding = 16
                rightPadding = 16
            }

            return UIEdgeInsets(top: topBottomPadding, left: leftPadding, bottom: topBottomPadding, right: rightPadding)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // memberCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.memberCollectionView {
            return CGSize(width: 80, height: collectionView.frame.height)
        }
        // habitSegmentCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView {
            return CGSize(
                width: self.view.frame.width / 4.5,
                height: 40
            )
        }
        // habitCardCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitCardCollectionView {
            return CGSize(
                width: self.view.frame.width / 2 - 25,
                height: self.view.frame.width / 2 + 20
            )
        }
        return CGSize()
    }
    
    //섹션의 행 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.habitProfileScrollView.habitProfileView.habitCardCollectionView {
            return 12
        }
        return 0
    }
    
    //섹션의 열 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.habitProfileScrollView.habitProfileView.habitCardCollectionView {
            return 20
        }
        return 8
    }
}

/// habitSegmentCollectionView를 위한 함수 익스텐션입니다.
extension HabitDiscoverViewController {
    
    /// habitSegmentCollectionView의 SegmentCell을 선택할때 호출하는 함수입니다.
    public func habitCV_select(
        row: Int,
        in section: Int = 0,
        animated: Bool = true
    ) {
        // Ensures selected row isnt more then data count
        guard row < habitSegmentCV_data.count else { return }
        
        // removes any selected items
        self.cleanupSelection()
        
        // set new selected item
        let indexPath = IndexPath(row: row, section: section)
        self.habitSegmentCV_selectedCellIndexPath = indexPath
        
        // Update selected cell
        let cell = self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.cellForItem(at: indexPath) as? HorizontalPickerViewCell
        cell?.configure(
            with: self.habitSegmentCV_data[indexPath.row],
            isSelected: true
        )
        
        self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.selectItem(
            at: indexPath,
            animated: animated,
            scrollPosition: .centeredHorizontally)
        
    }
    
    /// habitSegmentCollectionView의 SegmentCell을 선택할 때 이전 셀의 선택강조를 지웁니다.
    private func cleanupSelection() {
        guard let indexPath = habitSegmentCV_selectedCellIndexPath else { return }
        let cell = self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.cellForItem(at: indexPath) as? HorizontalPickerViewCell
        cell?.configure(with: habitSegmentCV_data[indexPath.row])
        habitSegmentCV_selectedCellIndexPath = nil
    }
}


/// Preview 코드 -> ViewController
import SwiftUI
struct HabitDiscoverViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitDiscoverViewController()
            let navigationController = UINavigationController(rootViewController: ViewController)
            return navigationController
        }
        //.previewLayout(.fixed(width: 400, height: 1200))
        //.preferredColorScheme(.dark)
        //.previewDevice("iPhone 8")
    }
}
