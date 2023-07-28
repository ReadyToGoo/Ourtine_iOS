//
//  HabitDiscoverViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/26.
//

import UIKit
import SnapKit

class HabitDiscoverViewController: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate {
    
    var habitSegmentCV_data: [String] = []
    var habitSegmentCV_selectedCellIndexPath: IndexPath?
    
    // habitProfileView 등록
    lazy var habitProfileScrollView = HabitDiscoverScrollView()
    
    // view 로드할 때 habitProfileView로 가져오기
    override func loadView() {
        super.loadView()
        //view = habitProfileScrollView
        view.backgroundColor = .white
    }
    
    // 상단 서치바 누르면 검색창으로 이동
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let nextVC = SearchViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        // habitProfileScrollView 설정
        view.addSubview(habitProfileScrollView)
        habitProfileScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide) // safe area에 맞춰서 상단에 배치됩니다.
            make.left.right.equalToSuperview() // 좌우 양쪽에 꽉 차게 설정합니다.
            make.bottom.equalToSuperview() // 아래쪽에 꽉 차게 설정합니다.
        }
        
        self.habitProfileScrollView.delegate = self
        
        //MARK: - topBar의 searchBar 연결
        self.habitProfileScrollView.habitProfileView.topBar.searchBar.delegate = self
        
        //MARK: - memberTableViewCell 파일 register
        self.habitProfileScrollView.habitProfileView.memberCollectionView.register(MemberCollectionViewCell.self, forCellWithReuseIdentifier: MemberCollectionViewCell.identifier)
        
        //MARK: - habitSegmentCollectionViewCell 파일 register
        self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.register(HorizontalPickerViewCell.self, forCellWithReuseIdentifier: HorizontalPickerViewCell.identifier)
        
        //MARK: - memberTableView 연결
        self.habitProfileScrollView.habitProfileView.memberCollectionView.delegate = self
        self.habitProfileScrollView.habitProfileView.memberCollectionView.dataSource = self
        
        //MARK: - habitSegmentCollectionView 연결
        self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.dataSource = self
        self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.delegate = self
        
        //MARK: - habitSegmentCollectionView 초기 설정
        setUp_habitCV_Data()
        DispatchQueue.main.async {
            self.habitCV_select(row: 0)
        }

        //headerViewYPosition = self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.frame.origin.y

    }
    
    /// habitSegmentCV의 데이터를 페칭합니다.
    private func setUp_habitCV_Data() {
        for habit in Dummy_habitCategories {
            habitSegmentCV_data.append(habit.name)
        }
    }
    
    // 최초 Y좌표는 지정값이 아닌 계산된 동적값이어야 합ㅂ니다 수정필
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // collectionView의 초기 Y 좌표를 설정합니다.
            let habitCV_initialYPosition: CGFloat = 240 // 예시로 Y 좌표를 200으로 설정합니다.
            // 스크롤된 거리를 계산합니다.
            let yOffset = scrollView.contentOffset.y

            
        if yOffset > 0 {
            self.habitProfileScrollView.habitProfileView.topBar.frame.origin.y = yOffset
        } else {
            self.habitProfileScrollView.habitProfileView.topBar.frame.origin.y = 0
        }
        
        // collectionView가 상단에 고정되어야 하는 지점까지 스크롤 되었을 때, 상단에 고정시킵니다.
        if yOffset > habitCV_initialYPosition - self.habitProfileScrollView.habitProfileView.topBar.bounds.height  {
                self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.frame.origin.y = yOffset + self.habitProfileScrollView.habitProfileView.topBar.bounds.height
            } else {
                // 초기 위치보다 위로 스크롤 되었을 때는 초기 위치로 이동시킵니다.
                self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.frame.origin.y = habitCV_initialYPosition
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
        else if collectionView == self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView {
            return habitSegmentCV_data.count
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
        else if collectionView == self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HorizontalPickerViewCell.identifier,
                for: indexPath
            ) as? HorizontalPickerViewCell else { return UICollectionViewCell() }
            cell.configure(with: habitSegmentCV_data[indexPath.row])
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
        }
        // habitSegmentCollectionView일 때
        else if collectionView == self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView {
            habitCV_select(row: indexPath.row)
        }
        
    }
    
}

/// CollectionView의  FlowLayout 상속 내용입니다
extension HabitDiscoverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // memberCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.memberCollectionView {
            return CGSize(width: 80, height: collectionView.frame.height)
        }
        // habitSegmentCollectionView일 때
        else if collectionView == self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView {
            return CGSize(
                width: self.view.frame.width / 4,
                height: 40
            )
        }
        
        return CGSize()
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
        .preferredColorScheme(.dark)
        //.previewDevice("iPhone 8")
    }
}
