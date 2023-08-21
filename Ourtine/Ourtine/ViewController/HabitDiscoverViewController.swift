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
/// + 친구 목록 불러오기 - FollowAPI - getMyFollwersList
/// + 관심 카테고리 불러오기 - UserAPI - getUserProfile
/// + 해당 카테고리의 습관 목록 불러오기 - HabitAPI - getDiscoverHabit
class HabitDiscoverViewController: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate {
    
    // habitSegment를 위한 데이터
    var habitSegmentCV_data: [String] = []
    var habitSegmentCV_selectedCellIndexPath: IndexPath?
    
    // habitProfileView 등록
    lazy var habitProfileScrollView = HabitDiscoverScrollView()
    
    /// 친구 목록 결과 리스트 입니다. API로 받아옵니다.
    private var memberResultList: [MemberModel] = []
    
    /// 관심 카테고리  결과 리스트 입니다. API로 받아옵니다.
    private var categoriesResultList: [String] = []
    
    /// 습관 찾기 결과 리스트 입니다. API로 받아옵니다.
    private var habitResultList: [HabitCardModel] = []
    
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
        
        fetchMemberData()
        
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
        fetchMyCategories {
            DispatchQueue.main.async {
                // fetchMyCategories 함수 내에서 데이터가 설정된 후에 호출
                self.habitCV_select(row: 0)
            }
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
//    private func setUp_habitCV_Data() {
//        for habit in Dummy_habitCategories {
//            habitSegmentCV_data.append(habit.name)
//        }
//    }
    
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
    
    // 상단 유저들의 프로필을 서버에서 갖고옵니다.
    func fetchMemberData() {
        let followAPI = MoyaWrapper<FollowAPI>(endPointClosure: MoyaProvider.defaultEndpointMapping,
                                               stubClosure: MoyaProvider.immediatelyStub)
        followAPI.requestSuccessRes(target: .getMyFollowingsList, instance: data_getMyFollowingsList.self) { result in
            
            var inputList:[MemberModel] = []
            
            switch result {
            case .success(let result):
                print(result)
                for item in result.content {
                    inputList.append(MemberModel(nil, item.profileImage, item.nickname, item.userId))
                }
                self.memberResultList = inputList
                self.habitProfileScrollView.habitProfileView.memberCollectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchMyCategories(closure: @escaping () -> Void) {
        let userAPI = MoyaWrapper<UserAPI>()
        userAPI.requestSuccessRes(target: .getUserProfile(userId: myInfo.myID ?? 0), instance: data_getUserProfile.self)
        { result in
            switch result {
            case .success(let result):
                print(result)
                var inputList:[String] = []
                for item in result.userCategoryList {
                    //print(categoryValueFromResponseData(text: item))
                    inputList.append(item)
                }
                self.categoriesResultList = inputList
                self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.reloadData()
                
                // 데이터 설정 완료 후 closure 호출
                closure()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchHabitData() {
        let selectedIndex = self.habitSegmentCV_selectedCellIndexPath
        // Update selected cell
        let cell = self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.cellForItem(at: selectedIndex ?? IndexPath()) as? HorizontalPickerViewCell
        
        if let selectedCategory = cell?.titleLabel.text  {
            let convertedCategory = convertCategoryNameToEnglish(text: selectedCategory)
            var inputList:[HabitCardModel] = []
            let habitAPI = MoyaWrapper<HabitAPI>()
            habitAPI.requestSuccessRes(target: .getDiscoverHabit(category: convertedCategory), instance: data_getDiscoverHabit.self)
            { result in
                switch result {
                case .success(let result):
                    print(result)
                    for item in result.content {
                        print(item.id)
                        inputList.append(HabitCardModel(habitId: item.id, image: item.imageUrl, title: item.category , habitName: item.title , userName: item.hostName , userImage: item.hostImageUrl, days: item.days, startTime: item.startTime, endTime: item.endTime))
                    }
                    self.habitResultList = inputList
                    self.habitProfileScrollView.habitProfileView.habitCardCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
        
        
        
//        switch selectedIndex {
//        case 0:
//            var inputList:[HabitCardModel] = []
//            let habitAPI = MoyaWrapper<HabitAPI>()
//            habitAPI.requestSuccessRes(target:.getSearchHabit(sort_by: filterString, keyword: searchTarget ?? ""), instance: data_getSearchHabit.self){ result in
//                switch result {
//                case .success(let result):
//                    print(result)
//                    for item in result.content {
//                        print(item.id)
//                        inputList.append(HabitCardModel(habitId: item.id, image: item.imageUrl, title: item.category ?? "none", habitName: item.title ?? "none", userName: item.hostName ?? "none", userImage: item.hostImageUrl, days: item.days, startTime: item.startTime, endTime: item.endTime))
//                    }
//                    self.habitResultList = inputList
//                    self.searchResultView.searchResultCollectionView.reloadData()
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        case 1:
//            var inputList:[UserModel] = []
//            let userAPI = MoyaWrapper<UserAPI>()
//            userAPI.requestSuccessRes(target: .getSearchUserNickName(keyword: searchTarget ?? ""), instance: data_getSearchUserNickName.self) { result in
//                switch result {
//                case .success(let result):
//                    print(result)
//                    for item in result.content {
//                        inputList.append(UserModel(item.userId ?? 0, item.profileImage, item.nickname ?? "", nil))
//                    }
//                    self.userNameResultList = inputList
//                    self.searchResultView.searchResultTableView.reloadData()
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        default :
//            print("unexpected Error")
//            return
//        }
    }
}

/// CollectionView의 Delegate와 DataSource 상속 내용입니다
extension HabitDiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// numberOfItemsInSection : cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // memberCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.memberCollectionView {
            return self.memberResultList.count
        }
        // habitSegmentCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView {
            return self.categoriesResultList.count
        }
        // habitCardCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitCardCollectionView {
            return self.habitResultList.count
        }
        // 예외 상황
        return 0
    }
    
    /// cellForItemAt : cell 내용 배정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // memberCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.memberCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.identifier, for: indexPath) as? MemberCollectionViewCell else { return UICollectionViewCell() }
            cell.getMemberData(data: self.memberResultList[indexPath.row])
            return cell
        }
        // habitSegmentCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HorizontalPickerViewCell.identifier,
                for: indexPath
            ) as? HorizontalPickerViewCell else { return UICollectionViewCell() }
            
            if indexPath == self.habitSegmentCV_selectedCellIndexPath {
                cell.configure(with: self.categoriesResultList[indexPath.row], isSelected: true)
            }
            else {
                cell.configure(with: self.categoriesResultList[indexPath.row])
            }
            return cell
        }
        // habitCardCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitCardCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HabitCardCollectionViewCell.identifier,
                for: indexPath
            ) as? HabitCardCollectionViewCell else { return UICollectionViewCell() }
            cell.getHabitsData(data: self.habitResultList[indexPath.row])
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
//            print("member \(indexPath.row) selected")
            print("userId : \(self.memberResultList[indexPath.row].userId)")
        }
        // habitSegmentCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView {
            habitCV_select(row: indexPath.row)
        }
        // habitCardCollectionView일 때
        if collectionView == self.habitProfileScrollView.habitProfileView.habitCardCollectionView {
            // 습관 카드 셀 눌렀을 때 동작
            print(self.habitResultList[indexPath.row].habitName)
            print("habitId : \(self.habitResultList[indexPath.row].habitId ?? -100)")
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
        if collectionView == self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView {
            return 10
        }
        return 30
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
        guard row < self.categoriesResultList.count else { return }
        
        // removes any selected items
        self.cleanupSelection()
        
        // set new selected item
        let indexPath = IndexPath(row: row, section: section)
        self.habitSegmentCV_selectedCellIndexPath = indexPath
        
        // Update selected cell
        let cell = self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.cellForItem(at: indexPath) as? HorizontalPickerViewCell
        cell?.configure(
            with: self.categoriesResultList[indexPath.row],
            isSelected: true
        )
        
        self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.selectItem(
            at: indexPath,
            animated: animated,
            scrollPosition: .centeredHorizontally)
        fetchHabitData()
    }
    
    /// habitSegmentCollectionView의 SegmentCell을 선택할 때 이전 셀의 선택강조를 지웁니다.
    private func cleanupSelection() {
        guard let indexPath = habitSegmentCV_selectedCellIndexPath else { return }
        let cell = self.habitProfileScrollView.habitProfileView.habitSegmentCollectionView.cellForItem(at: indexPath) as? HorizontalPickerViewCell
        cell?.configure(with: self.categoriesResultList[indexPath.row])
        habitSegmentCV_selectedCellIndexPath = nil
    }
}


/// Preview 코드 -> ViewController
import SwiftUI
import Moya
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
